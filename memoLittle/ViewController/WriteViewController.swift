//
//  WriteViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 16..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
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
        print("버튼 눌러졌습니다.")
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
