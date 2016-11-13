//
//  MusicLIstTableViewCell.swift
//  VolumeKeeper
//
//  Created by 이동규 on 2016. 11. 13..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import MarqueeLabel

class MusicLIstTableViewCell: UITableViewCell {

    @IBOutlet weak var titleImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: MarqueeLabel!
    
    @IBOutlet weak var albumLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.type = .continuous
        titleLabel.trailingBuffer = 30
        titleLabel.fadeLength = 10
        titleLabel.speed = .duration(8)
        titleLabel.textAlignment = .left
    }
}
