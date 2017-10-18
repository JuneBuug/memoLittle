//
//  WriteViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 16..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit
import RealmSwift

class WriteViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var writer = Person()

    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = false
        keyboardToolbar.barTintColor = UIColor.white
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(sth)
        )
        addButton.tintColor = UIColor.black
        keyboardToolbar.items = [addButton]
        textView.inputAccessoryView = keyboardToolbar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sth(){
        let obj = LittleLine()
        obj.objectName = textView.text
        obj.writer = writer
        obj.category = 0
        obj.id = UUID().uuidString
        try! realm.write{
            realm.add(obj)
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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
