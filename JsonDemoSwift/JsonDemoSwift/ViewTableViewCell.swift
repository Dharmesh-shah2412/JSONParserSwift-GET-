//
//  ViewTableViewCell.swift
//  JsonDemoSwift
//
//

import UIKit

class ViewTableViewCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAge: UILabel!
    @IBOutlet var lbldisplayName: UILabel!
    @IBOutlet var lblDisplayAge: UILabel!
    @IBOutlet var lblFName3: UILabel!
    @IBOutlet var lblFName2: UILabel!
    @IBOutlet var lblid3: UILabel!
    @IBOutlet var lblid1: UILabel!
    @IBOutlet var lblFName1: UILabel!
    
    @IBOutlet var lblid2: UILabel!
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
