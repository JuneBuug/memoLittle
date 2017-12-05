//
//  Memo.swift
//  memoCore
//
//  Created by 준킴 on 2017. 12. 6..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import Foundation
import Intents

public struct Memo: Codable {
    public let contents : String
    public let writer : String
    private static let contentsKey = "memoContents"
    private static let writerKey = "memoWriter"
    public init(contents: String, writer: String){
        self.contents = contents
        self.writer  = writer
    }
    
    public var speakableString: INSpeakableString {
        let identifier : String
        let phrase : String
        let hint : String
        
        identifier = "id-memotype-default"
        phrase = "Memo"
        hint = "memo"
        
        if #available(iOS 11.0, *) {
            return INSpeakableString(vocabularyIdentifier: identifier, spokenPhrase: phrase, pronunciationHint: hint)
        }
        else {
            return INSpeakableString(identifier: identifier, spokenPhrase: phrase, pronunciationHint: hint)
        }
    }
    
    private static func userDefaults() -> UserDefaults {
        guard let defaults = UserDefaults(suiteName: "com.junebuug.memoCore") else {
            fatalError("failed to create UserDefaults suite")
        }
        return defaults
    }

    public static func load() -> Memo {
        if let contents = Memo.userDefaults().string(forKey: Memo.contentsKey){
            if let writer = Memo.userDefaults().string(forKey: Memo.writerKey){
                print("여기까지 들어는 갔어")
                return Memo(contents: contents,writer: writer)
            }
            print("writer를 인식 못한 경우")
        }
        print("그냥 로드를 못한 경우")
        return Memo(contents:"",writer:"내용없는메모")
    }
    
    public func save(){
        print("잘넘어왔나?"+contents)
        print(writer)
        Memo.userDefaults().set(contents, forKey: Memo.contentsKey)
        Memo.userDefaults().set(writer, forKey: Memo.writerKey)
    }
}