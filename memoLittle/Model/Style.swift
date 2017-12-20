//
//  Style.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 12. 20..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    static var backgroundColor = UIColor(red: 241.0/255.0 , green: 241.0/255.0, blue : 239.0/255.0, alpha :1.0)
    static var tintColor = UIColor(red: 0.0/255.0,green: 175.0/255.0,blue:126.0/255.0,alpha: 1.0)
    static var writeBackgroundColor = UIColor.white
    static var hashtagColor = UIColor(red: 255.0/255.0, green: 197.0/255.0, blue: 6.0/255.0, alpha: 1.0)
    static var textColor = UIColor(red: 71.0/255.0, green: 71.0/255.0, blue: 71.0/255.0, alpha: 1.0)
    
    static func themeNight(){
        backgroundColor = UIColor(red: 27.0/255.0 , green: 41.0/255.0, blue : 54.0/255.0, alpha :1.0)
        tintColor = UIColor(red: 255.0/255.0,green: 189.0/255.0,blue: 0.0/255.0,alpha: 1.0)
        writeBackgroundColor = backgroundColor
        hashtagColor = UIColor.white
        textColor = UIColor.white
    }
    
    static func themeNormal(){
        backgroundColor = UIColor(red: 241.0/255.0 , green: 241.0/255.0, blue : 239.0/255.0, alpha :1.0)
        tintColor = UIColor(red: 0.0/255.0,green: 175.0/255.0,blue:126.0/255.0,alpha: 1.0)
        writeBackgroundColor = UIColor.white
        hashtagColor = UIColor(red: 255.0/255.0, green: 197.0/255.0, blue: 6.0/255.0, alpha: 1.0)
        textColor = UIColor.black
    }
}
