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

    @IBOutlet weak var usernameHeaderLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postPFImageView: PFImageView!
    @IBOutlet weak var usernameFooterLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var post: PFObject! {
        didSet {
            self.postPFImageView.file = post["media"] as? PFFile
            self.postPFImageView.loadInBackground()
            
            self.captionLabel.text = post["caption"] as? String
       
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "EEE, MMM d, h:mm a"
            let time = post.createdAt! as Date
            timeStampLabel.text = String(format: "%@", dateFormat.string(from: (time)))
            
            let user = post["author"] as? PFObject
           
            user?.fetchInBackground(block: { (user: PFObject?, error: Error?) in
                let username = user?["username"] as? String
                
                self.usernameFooterLabel.text = username
                self.usernameHeaderLabel.text = username
            
            })
            
            
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
