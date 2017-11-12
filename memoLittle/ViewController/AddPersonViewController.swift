//
//  AddPersonViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 18..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit
import RealmSwift

class AddPersonViewController: UIViewController {
    // 사람 정보 수정 View로 적용

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var relationship: UITextView!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can bse recreated.
    }
    
    @IBAction func onTouchWrite(_ sender: Any) {
        let obj = Person()
        obj.name = textView.text
        obj.relationship = relationship.text
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
