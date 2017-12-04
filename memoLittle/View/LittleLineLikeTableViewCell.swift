//
//  LittleLineLikeTableViewCell.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 13..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class LittleLineLikeTableViewCell: UITableViewCell {

    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var likeObject: UILabel!
    @IBOutlet weak var tags: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
