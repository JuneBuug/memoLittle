//
//  Network.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 12. 22..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import Foundation


class Network {
    
    static func dataPost(text : String)  {
        
        let json : [String: String] = ["text": text, "icon_url":"http://emojis.slackmojis.com/emojis/images/1450451598/168/doge2.png?1450451598", "username": "memoLittle"]
        // 보내고자하는 데이터
        
        let url = URL(string:"https://hooks.slack.com/services/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")
        // 데이터를 보낼 주소
        var request = URLRequest(url: url!)
        // 그 주소에 대한 요청
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
        // 보낼 데이터를 json으로 묶어서 보내주겠다
        
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request as URLRequest) {
            data, response, error  in
            
            if error != nil {
            }else{
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "postSuccess"), object: nil)
            }
            }.resume()
        
    }
}
