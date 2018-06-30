//
//  ViewController.swift
//  MoyaDemo
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- Variables
    //MARK:-
    
    var objPostList = [PostList]()
    var arr : NSMutableArray = NSMutableArray()
    var arrString = [String]()
    
    //MARK:- Outlets
    //MARK:-
    
    @IBOutlet weak var tblView: UITableView!
    
    //MARK:- View Lifecycle
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK:- Tableview Methods
    //MARK:-
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return objPostList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let objCell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")as! TableViewCell
        objCell.lblTittle.text = objPostList[indexPath.row].title
        objCell.lblOverview.text = objPostList[indexPath.row].body
        return objCell
    }
    
    //MARK:- APi Calling
    //MARK:-
    
    func callNormalApi() {
        let api = AllApi.getPosts()
        APIManager.request(target: api, success: { (result) in
            
            if let  arrData = result.array {
                self.objPostList = arrData.map({PostList.init(json: $0)})
                self.tblView.reloadData()
            }
            
        }, error: { (error) in
            
            print(error)
            
        }) { (failure) in
            
            print(failure)
            
        }
    }
    
    func callMultipartApi() {
        let params = ["name" : "Test",
                      "image" : UIImage(named: "test")!] as [String : Any]
        let api1 = AllApi.register(params: params)
        APIManager.request(target: api1, success: { (result) in
            print(result)
        }, error: { (error) in
            print(error)
        }) { (failure) in
            print(failure)
        }
    }
    
    func test(){
        
        
    }
    //MARK:- Button Action
    //MARK:-
    
    @IBAction func btnClickApiCall(_ sender: Any) {
        callNormalApi()
        
    }
}

