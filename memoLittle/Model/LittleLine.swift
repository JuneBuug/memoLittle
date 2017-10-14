//
//  LittleLine.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 14..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import Foundation

class LittleLine {
    
    var category : Int // 리틀라인 게시글 종류 0 : 좋아하는 것 1: 날짜 관련 이벤트
    var personName : String // 사람 이름
    var objectName : String // 대상 이름 / 이벤트 이름
    var id : Int // 해당 내용의 id
    
    
    init(){
        category = 0
        personName = ""
        objectName = ""
        id = 0
    }
    
    init(category: Int,personName : String,objectName : String, id: Int){
        self.category = category
        self.personName = personName
        self.objectName = objectName
        self.id = id
    }
    
}
