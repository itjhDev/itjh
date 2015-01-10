//
//  HomeArticleTableViewCell.swift
//  itjh
//
//  Created by LijunSong on 14/10/30.
//  Copyright (c) 2014年 itjh. All rights reserved.
//

import UIKit

class HomeArticleTableViewCell: UITableViewCell {

    @IBOutlet var atitle: UITextView!
    @IBOutlet var aimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
