//
//  SongTableViewCell.swift
//  EarOfTheParty
//
//  Created by Tim Pusateri on 5/2/16.
//  Copyright © 2016 Tim Pusateri. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var upVoteButton: UIButton!
    @IBOutlet weak var downVoteButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var ablumLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
