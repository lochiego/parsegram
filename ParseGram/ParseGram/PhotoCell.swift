//
//  PhotoCell.swift
//  ParseGram
//
//  Created by Eric Gonzalez on 3/4/16.
//  Copyright © 2016 Eric Gonzalez. All rights reserved.
//

import UIKit
import ParseUI

class PhotoCell: UITableViewCell {

  @IBOutlet weak private var photoView: PFImageView!
  @IBOutlet weak private var captionLabel: UILabel!
  
  var photo: PFObject! {
    didSet {
      captionLabel.text = photo["caption"] as? String
      photoView.file = photo["media"] as? PFFile
      photoView.loadInBackground()
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
