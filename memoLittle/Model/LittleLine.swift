//
//  LittleLine.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 14..
//  Copyright © 2017년 junebuug. All rights reserved.
//


import RealmSwift

// 타임라인 글
final class LittleLine : Object {
    
    @objc dynamic var category = 0 // 리틀라인 게시글 종류 0 : 좋아하는 것 1: 날짜 관련 이벤트
    @objc dynamic var writer: Person? // 이 대상 사람
    @objc dynamic var personName = "" // 검색을 위한 사람 이름
    @objc dynamic var objectName = "" // 대상 이름 / 이벤트 이름
    @objc dynamic var id = UUID().uuidString // 해당 내용의 id
    @objc dynamic var createdDate : Date = Date()
    var tags = List<RealmString>()

    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

// 사람
final class Person : Object {
    @objc dynamic var name = "" // 사람 이름
    @objc dynamic var relationship = "" // 이 사람과의 관계
    @objc dynamic var id = UUID().uuidString // 사람 id
    var profile = Photo()
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class RealmString : Object {
    @objc dynamic var stringValue = ""
}

// 사진
final class Photo : Object {
    @objc dynamic var createDate: Date = Date()
    @objc dynamic var image: Data?
}
