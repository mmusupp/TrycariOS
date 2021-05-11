//
//  PostTableCell.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import UIKit

class PostTableCell: UITableViewCell {

    @IBOutlet weak var postImageVIew: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var favoriteIcon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var item: Post? {
        didSet {
            self.postTitle.text = item?.title ?? ""
        }
    }
    
}
