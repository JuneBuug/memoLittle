//
//  WriteViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 16..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit
import RealmSwift

class WriteViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    let realm = try! Realm()
    var placeholderLabel : UILabel!
    
    var list : Results<Person>! // 현재 등록되어 있는 사람 목록
    var notificationToken: NotificationToken!
    var attributed : NSMutableAttributedString! // String attr
    override func viewDidLoad() {
        super.viewDidLoad()

        
        list = realm.objects(Person.self)
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = false
        keyboardToolbar.barTintColor = UIColor.white
        
        // 작성완료 버튼
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(writeMemo)
        )
        
        // 더 작성하기 버튼
        let moreButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(moreMemo)
        )
        let hightlightColor = UIColor(red: 0.0/255.0, green: 175.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        doneButton.tintColor = hightlightColor
        moreButton.tintColor = UIColor.black
        
        keyboardToolbar.items = [doneButton,moreButton]
        
        
        textView.inputAccessoryView = keyboardToolbar
        textView.delegate = self
        textView.becomeFirstResponder()
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "@로 사람을 태그하고, 메모를 적어주세요 :)"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func writeMemo(){
        let tagList = checkandReturnHashtag(text: textView.text)
        if checkandReturnMention(text: textView.text).0 {
            
            var writer = Person()
            let mentionedName = checkandReturnMention(text: textView.text).1
           
            let foundList = list.filter("name == [c]%@",mentionedName)
            
            if let person = foundList.first  {
                writer = person
            }else{
                 writer.name = mentionedName
            }
            
            let obj = LittleLine()
            var str = textView.text.replacingOccurrences(of: "@"+mentionedName, with: "")
            for tag in tagList{
                obj.tags.append(RealmString(value: ["stringValue":tag]))
                str = str.replacingOccurrences(of: "#"+tag, with: "")
            }
           
            obj.objectName = str
            obj.personName = mentionedName
            obj.writer = writer
           
            obj.category = 0
            try! realm.write{
                realm.add(writer)
                realm.add(obj)
            }
        }else{
            //TODO mention이 없다면 처리
            let obj = LittleLine()
            var str = textView.text
            obj.category = 0
            for tag in tagList{
                obj.tags.append(RealmString(value: ["stringValue":tag]))
                str = str?.replacingOccurrences(of: "#"+tag, with: "")
            }
            obj.objectName = str!
            try! realm.write{
                realm.add(obj)
            }
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func moreMemo(){
        if checkandReturnMention(text: textView.text).0 {
            
            var writer = Person()
            let mentionedName = checkandReturnMention(text: textView.text).1
            let foundList = list.filter("name == [c]%@",mentionedName)
            
            if let person = foundList.first  {
                writer = person
            }else{
                writer.name = mentionedName
            }
            
            let obj = LittleLine()
            obj.objectName = textView.text.replacingOccurrences(of: "@"+mentionedName, with: "")
            obj.personName = mentionedName
            obj.writer = writer
            obj.category = 0
            try! realm.write{
                realm.add(writer)
                realm.add(obj)
            }
        }else{
            //TODO mention이 없다면 처리
            let obj = LittleLine()
            obj.objectName = textView.text
            obj.category = 0
            try! realm.write{
                realm.add(obj)
            }
        }
        textView.text = ""
    }

    // mention 이 있는 지 여부를 확인하고 있다면 mention name을 return 하는 함수
    func checkandReturnMention(text: String) -> (Bool,String){
        
        if text.contains("@") {
            let textArr = text.split(separator: " ")
            
            for word in textArr {
                if word.starts(with: "@"){
                    if word.count > 1 {
                        let name = word.dropFirst()
                        return (true,String(name))
                    }
                }
            }
        }
        return (false,"")
    }
    
    // hashtag 가 있는 지 여부를 확인하고 있으면 hashtag return
    func checkandReturnHashtag(text: String) -> ([String]){
        
        var hashtags : [String] = []
        if text.contains("#") {
            let textArr = text.split(separator: " ")
            
            for word in textArr {
                if word.starts(with: "#"){
                    if word.count > 1 {
                        let name = word.dropFirst()
                        hashtags.append(String(name))
                    }
                }
            }
        }
        
        return hashtags
    }
    
    
    // 편집 중일 때
    func textViewDidChange(_ textView: UITextView){
        placeholderLabel.isHidden = !textView.text.isEmpty
        attributed = NSMutableAttributedString(string : textView.text)
        if checkandReturnMention(text: textView.text).0 {
            let searchString = checkandReturnMention(text: textView.text).1
            let baseString = textView.text!
            
            
            let hightlightColor = UIColor(red: 0.0/255.0, green: 175.0/255.0, blue: 126.0/255.0, alpha: 1.0)
            do
            {
                let regex = try! NSRegularExpression(pattern: searchString,options: .caseInsensitive)
                for match in regex.matches(in: baseString, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: baseString.characters.count)) as [NSTextCheckingResult] {
                    attributed.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14.0), range: match.range)
                    attributed.addAttribute(NSAttributedStringKey.foregroundColor, value: hightlightColor, range: match.range)
                }
                DispatchQueue.main.async{
                    self.textView.attributedText = self.attributed
                }
            }
        }
        
        if checkandReturnHashtag(text: textView.text) != [] {
            for searchString in checkandReturnHashtag(text: textView.text){
                let baseString = textView.text!
                
                let hightlightColor = UIColor(red: 255.0/255.0, green: 197.0/255.0, blue: 6.0/255.0, alpha: 1.0)
                do
                {
                    let regex = try! NSRegularExpression(pattern: "#"+searchString,options: .caseInsensitive)
                    for match in regex.matches(in: baseString, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: baseString.characters.count)) as [NSTextCheckingResult] {
                        attributed.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14.0), range: match.range)
                        attributed.addAttribute(NSAttributedStringKey.foregroundColor, value: hightlightColor, range: match.range)
                    }
                    DispatchQueue.main.async{
                        self.textView.attributedText = self.attributed
                    }
                }
            }
        }
      
    }
    @IBAction func onTouchClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


