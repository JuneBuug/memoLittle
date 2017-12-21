//
//  AppInfoViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 12. 22..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCloseBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

}
