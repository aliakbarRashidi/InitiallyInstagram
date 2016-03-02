//
//  HomeCell.swift
//  InitiallyInstagram
//
//  Created by Anisha Gupta on 3/1/16.
//  Copyright © 2016 ani6gup. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var pictureView: PFImageView!
    
    
    var picsPlusCaption: PFObject! {
        didSet{
            self.captionLabel.text = picsPlusCaption["caption"] as! String?
            let picture = picsPlusCaption["picture"] as! PFObject
           self.pictureView.file = picture["image"] as? PFFile
           self.pictureView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
