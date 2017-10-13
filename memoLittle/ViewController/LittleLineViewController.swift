//
//  LittleLineViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 13..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class LittleLineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "LittleLineLikeTableViewCell", bundle: nil), forCellReuseIdentifier: "LittleLineLikeTableViewCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension LittleLineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineLikeTableViewCell",for: indexPath) as! LittleLineLikeTableViewCell
        return cell
    }
}
