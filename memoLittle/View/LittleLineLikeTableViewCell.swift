//
//  LittleLineLikeTableViewCell.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 13..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class LittleLineLikeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameSubLabel: UILabel!
    @IBOutlet weak var timeline: UIView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var likeObject: UILabel!
    @IBOutlet weak var tags: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: NSNotification.Name("updateTheme"), object: nil)
        // Initialization code
    }

    @objc func setupUI(){
        backgroundView?.backgroundColor = Style.backgroundColor
        contentView.backgroundColor = Style.backgroundColor
        timeline.backgroundColor = Style.lineColor
        nameSubLabel.textColor = Style.textColor
        personName.textColor = Style.textColor
        likeObject.textColor = Style.textColor
        tags.textColor = Style.tintColor
        self.contentView.backgroundColor = Style.backgroundColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
