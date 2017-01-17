//
//  SongListCell.swift
//  Music
//
//  Created by MacBook Pro  on 2016/11/30.
//  Copyright © 2016年 yucong shen. All rights reserved.
//

import UIKit

class SongListCell: UITableViewCell {

    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
