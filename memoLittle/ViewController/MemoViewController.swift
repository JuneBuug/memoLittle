//
//  MemoViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 14..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit
import RealmSwift

class MemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var list : Results<Person>!
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupRealm()
        list = realm.objects(Person.self)
        notificationToken = list.addNotificationBlock({ (change) in
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRealm() {
        // Log in existing user with username and password
        do {
            realm = try Realm()
        } catch {
            print("\(error)")
        }
    }
    // 사람 추가 view로 이동
    @IBAction func onTouchAddBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPersonViewController") as! AddPersonViewController
        self.present(vc, animated: true, completion: nil)
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

extension MemoViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .none
        cell.textLabel?.text = list[indexPath.row].name + " | " + list[indexPath.row].relationship
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteViewController") as! WriteViewController
        vc.writer = list[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}
