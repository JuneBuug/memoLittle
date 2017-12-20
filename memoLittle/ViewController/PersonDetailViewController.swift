//
//  PersonDetailViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 11. 12..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit
import RealmSwift

class PersonDetailViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // 이 상세 정보의 메인 object가 되는 사람
    var person = Person(){
        didSet{
            filterList()
        }
    }
    
    var list : Results<LittleLine>!
    var notificationToken: NotificationToken!
    var notificationToken2: NotificationToken!
    var realm: Realm!
    var personList: Results<Person>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRealm()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LittleLineLikeTableViewCell", bundle: nil), forCellReuseIdentifier: "LittleLineLikeTableViewCell")
        tableView.register(UINib(nibName: "LittleLineEventTableViewCell", bundle: nil), forCellReuseIdentifier: "LittleLineEventTableViewCell")
        
        list = realm.objects(LittleLine.self)
        personList = realm.objects(Person.self)
        filterList()
        notificationToken = list.addNotificationBlock({ (change) in
            self.tableView.reloadData()
        })
        notificationToken2 = personList.addNotificationBlock({ (change) in
             self.tableView.reloadData()
        })
        setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        Style.themeNight()
        self.view.backgroundColor = Style.backgroundColor
        self.tableView.backgroundColor = Style.backgroundColor
        self.closeBtn.tintColor = Style.tintColor
    }

    
    func setupRealm() {
        // Log in existing user with username and password
        do {
            realm = try Realm()
        } catch {
            print("\(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func filterList(){
        if list != nil {
            list = realm.objects(LittleLine.self).filter("writer == %@",person).sorted(byKeyPath: "createdDate", ascending: false)
            tableView.reloadData()
        }
    }

}

extension PersonDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if list[indexPath.row].category == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineLikeTableViewCell",for: indexPath) as! LittleLineLikeTableViewCell
            cell.personName.text? = (list[indexPath.row].writer?.name)!
            cell.likeObject.text? = list[indexPath.row].objectName
            
            if list[indexPath.row].tags.first?.stringValue != "" {
                cell.tags.isHidden = false
                var str = ""
                for tag in list[indexPath.row].tags {
                    str += "#"+tag.stringValue+" "
                }
                cell.tags.text = str
            }else{
                cell.tags.isHidden = true
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineEventTableViewCell",for: indexPath) as! LittleLineEventTableViewCell
            cell.personName.text? = (list[indexPath.row].writer?.name)!
            cell.eventLabel.text? = list[indexPath.row].objectName
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = PeopleDetailHeader.instanceFromNib()
        headerView.personName.text = person.name
        headerView.relationship.text = person.relationship
        
        if let profile = person.profile.image {
            headerView.profilePicture.image = UIImage(data:profile)
        }
        headerView.profilePicture.layer.borderWidth = 0
        headerView.profilePicture.layer.masksToBounds = false
        headerView.profilePicture.layer.cornerRadius = headerView.profilePicture.frame.height/2
        headerView.profilePicture.clipsToBounds = true
        return headerView
    }
}
