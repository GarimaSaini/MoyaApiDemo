//
//  APIManager.swift
//  MoyaDemo


import UIKit
import Moya
import SwiftyJSON
import Foundation
import Alamofire



let provider = MoyaProvider<AllApi>(plugins: [NetworkLoggerPlugin(verbose: true)])

class APIManager: NSObject {

    struct Parameter {
        static let uploadFILE = "FILE"
    }

    static func request(target: AllApi, success successCallback: @escaping (JSON) -> Void,   error errorCallback: @escaping (Swift.Error) -> Void,  failure failureCallback: @escaping (MoyaError) -> Void) {
        
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments) {
                    let objJsonResponse = JSON(json)
                    successCallback(objJsonResponse)
                    
//                    let status = objJsonResponse[ "status" ].rawValue as! Int
//                    if status == 1 {
//                        successCallback(objJsonResponse)
//                    }else{
//                        let error = NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"something went wrong try again later" ])
//                        errorCallback(error)
//
//                    }
//
                }
            case .failure(let error):
                // 3:
                failureCallback(error)
            }
        }
        
    }
    
    
}

//Make enum of all the apis you want to use



enum AllApi{
    case getPosts()
    case register(params : [String : Any])
    
}
//make extension of the enum type defined above ans set type as target type.Compiler will suggest all the protocols.ie. path,sampleData,task,headers,baseURL,method

extension AllApi :TargetType{

    // make switch for self and make cases for allthe cases of all apis list provided above.Return the api url excluding the base url.
    var path: String {
        switch self {
        case .getPosts:
            return "/posts"

        case .register:
            return "/register"
        }
    }

    var sampleData: Data {
        return Data()
    }
    
    // make switch for self and make cases for allthe cases of all apis list provided above.if it is multipart then return the data in formdata otherwise  requestparameters.
    var task: Task {
        switch self {
        
        case .register(let params):

            var aDictData = params
            if aDictData[APIManager.Parameter.uploadFILE] != nil {
                let data = UIImageJPEGRepresentation(params[APIManager.Parameter.uploadFILE] as! UIImage , 0.5)
                aDictData[APIManager.Parameter.uploadFILE] = data
            }

            var formData = [Moya.MultipartFormData]()
            for (key, value) in aDictData {
                if let imgData = value as? Data {
                    formData.append(MultipartFormData(provider: .data(imgData), name: key, fileName: "image.png", mimeType: "image/png"))
                }
                else {
                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
                }
            }
            return .uploadMultipart(formData)

        case .getPosts:
            return .requestParameters(parameters: ["":""], encoding: JSONEncoding.default)
        }


    }

    // make switch for self and make cases for allthe cases of all apis list provided above.And provide header in which it is required acc to the requirement.
    var headers: [String : String]? {
        switch self {
        case  .register, .getPosts :
            return ["Authorization": "Auth-Token" ,
                "Content-Type":"application/json" ]
    }

    }
    
    // return the base url of the apis
    var baseURL : URL{
        if let url = URL(string: "https://jsonplaceholder.typicode.com") {
            return url
        }
        else{
            return URL(string: "www.dummy.com")!
        }
    }

    // define which api is of which type ie. get ,post,put, delete etc...
    var method : Moya.Method{
        switch self {
        case .getPosts:
            return .get
        case .register:
            return .post
        }
    }


}
