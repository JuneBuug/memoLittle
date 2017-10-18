//
//  LittleLine.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 14..
//  Copyright © 2017년 junebuug. All rights reserved.
//


import RealmSwift

// 모델입니다
final class LittleLine : Object {
    
    @objc dynamic var category = 0 // 리틀라인 게시글 종류 0 : 좋아하는 것 1: 날짜 관련 이벤트
    @objc dynamic var personName = "" // 사람 이름
    @objc dynamic var objectName = "" // 대상 이름 / 이벤트 이름
    @objc dynamic var id = UUID().uuidString // 해당 내용의 id
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
