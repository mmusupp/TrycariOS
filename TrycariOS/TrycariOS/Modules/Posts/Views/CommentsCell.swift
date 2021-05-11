//
//  CommentsCell.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var lblComments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var item: CommentsDBModel? {
        didSet {
            self.lblComments.text = item?.body ?? ""
        }
    }
}
