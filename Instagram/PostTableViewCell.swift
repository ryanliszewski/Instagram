//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Ryan Liszewski on 3/6/17.
//  Copyright © 2017 Smiley. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postPFImageView: PFImageView!
    
    var post: PFObject! {
        didSet {
            print("test")
            print(post)
            self.postPFImageView.file = post["media"] as? PFFile
            self.postPFImageView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
