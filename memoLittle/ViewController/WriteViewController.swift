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
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = false
        keyboardToolbar.barTintColor = UIColor.white
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(writeMemo)
        )
        addButton.tintColor = UIColor.black
        keyboardToolbar.items = [addButton]
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
        if checkandReturnMention(text: textView.text).0 {
            let mentionedName = checkandReturnMention(text: textView.text).1
            let obj = LittleLine()
            let writer = Person()
            obj.objectName = textView.text.replacingOccurrences(of: "@"+mentionedName, with: "")
            obj.personName = mentionedName
            writer.name = mentionedName
            obj.writer = writer
            obj.category = 0
            try! realm.write{
                realm.add(writer)
                realm.add(obj)
            }
        }else{
            let obj = LittleLine()
            let writer = Person()
            obj.objectName = textView.text
            obj.category = 0
            try! realm.write{
                realm.add(obj)
            }
        }
       
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

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
    
    
    // 편집 중일 때
    func textViewDidChange(_ textView: UITextView){
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        if checkandReturnMention(text: textView.text).0 {
            let searchString = checkandReturnMention(text: textView.text).1
            let baseString = textView.text!
            
            let attributed = NSMutableAttributedString(string: baseString)
            let hightlightColor = UIColor(red: 0.0/255.0, green: 175.0/255.0, blue: 126.0/255.0, alpha: 1.0)
            do
            {
                let regex = try! NSRegularExpression(pattern: searchString,options: .caseInsensitive)
                for match in regex.matches(in: baseString, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: baseString.characters.count)) as [NSTextCheckingResult] {
                    attributed.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14.0), range: match.range)
                    attributed.addAttribute(NSAttributedStringKey.foregroundColor, value: hightlightColor, range: match.range)
                }
                DispatchQueue.main.async{
                    self.textView.attributedText = attributed
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


