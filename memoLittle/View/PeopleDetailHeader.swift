//
//  PeopleDetailHeader.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 11. 12..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class PeopleDetailHeader: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var relationship: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func instanceFromNib() -> PeopleDetailHeader {
        return UINib(nibName: "PeopleDetailHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PeopleDetailHeader
    }

}
