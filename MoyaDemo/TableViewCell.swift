//
//  TableViewCell.swift
//  MoyaDemo

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
