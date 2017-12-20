//
//  PeopleDetailHeader.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 11. 12..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class PeopleDetailHeader: UIView {

    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var relationship: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.personName.textColor = Style.textColor
        self.relationship.textColor = Style.tintColor
        self.personName.superview?.backgroundColor = Style.backgroundColor
    }
    
    class func instanceFromNib() -> PeopleDetailHeader {
        return UINib(nibName: "PeopleDetailHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PeopleDetailHeader
    }

}
