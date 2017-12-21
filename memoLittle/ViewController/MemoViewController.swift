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
    //사람 목록 view

    @IBOutlet weak var titleItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    var list : Results<Person>!
    var filtered_list : Results<Person>!
    var notificationToken: NotificationToken!
    var realm: Realm!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupRealm()
        list = realm.objects(Person.self)
        notificationToken = list.addNotificationBlock({ (change) in
            self.tableView.reloadData()
        })
        
        setupUI()
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.placeholder = "이름 혹은 관계로 검색해보세요."
        searchController.searchBar.setValue("취소", forKey:"_cancelButtonText")
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: NSNotification.Name("updateTheme"), object: nil)
        // Do any additional setup after loading the view.
    }

    @objc func setupUI(){
        self.view.backgroundColor = Style.backgroundColor
        self.tableView.backgroundColor = Style.backgroundColor
        navBar.barTintColor = Style.backgroundColor
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Style.textColor]
        titleItem.rightBarButtonItem?.tintColor = Style.tintColor
        searchController.view.backgroundColor = Style.backgroundColor
        searchController.searchBar.backgroundColor = Style.backgroundColor
        searchController.searchBar.barTintColor = Style.backgroundColor
        searchController.searchBar.tintColor = Style.textColor
        tableView.reloadData()
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
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteViewController") as! WriteViewController
        self.present(vc, animated: true, completion: nil)
    }
   
    
    func isFiltering() -> Bool {
        return searchController.isActive
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filtered_list = realm.objects(Person.self).filter("name CONTAINS[c]%@ OR relationship CONTAINS[c]%@",searchText,searchText)
        
        tableView.reloadData()
    }

}

extension MemoViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filtered_list.count
        }else{
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .none
        cell.textLabel?.textColor = Style.textColor
        cell.contentView.backgroundColor = Style.backgroundColor
        if isFiltering(){
            cell.textLabel?.text = filtered_list[indexPath.row].name + " | " + filtered_list[indexPath.row].relationship
        }else{
            cell.textLabel?.text = list[indexPath.row].name + " | " + list[indexPath.row].relationship
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PersonDetailViewController") as! PersonDetailViewController
        if isFiltering(){
            vc.person = filtered_list[indexPath.row]
        }else{
            vc.person = list[indexPath.row]
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if isFiltering(){
            // realm delete
            let deleteAction = UITableViewRowAction(style: .destructive, title: "삭제") { (deleteAction, indexPath) in
                do {
                    try self.realm.write {
                        var events = self.realm.objects(LittleLine.self).filter("writer = %@",self.filtered_list[indexPath.row])
                        for event in events {
                            self.realm.delete(event)
                        }
                        self.realm.delete(self.filtered_list[indexPath.row])
                        
                    }
                } catch {
                    print("\(error)")
                }
            }
            
            let editAction = UITableViewRowAction(style: .normal, title: "편집") { (editAction, indexPath) in
                // 사람 기본정보 수정 가능
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AddPersonViewController") as! AddPersonViewController
                vc.user = self.filtered_list[indexPath.row]
                self.present(vc, animated: true, completion: nil)
            }
             return [deleteAction, editAction]
        }else{
            // realm delete
            let deleteAction = UITableViewRowAction(style: .destructive, title: "삭제") { (deleteAction, indexPath) in
                do {
                    try self.realm.write {
                        var events = self.realm.objects(LittleLine.self).filter("writer = %@",self.list[indexPath.row])
                        for event in events {
                            self.realm.delete(event)
                        }
                        self.realm.delete(self.list[indexPath.row])
                        
                    }
                } catch {
                    print("\(error)")
                }
            }
            
            let editAction = UITableViewRowAction(style: .normal, title: "편집") { (editAction, indexPath) in
                // 사람 기본정보 수정 가능
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AddPersonViewController") as! AddPersonViewController
                vc.user = self.list[indexPath.row]
                self.present(vc, animated: true, completion: nil)
            }
             return [deleteAction, editAction]
        }
        
       
    }
    
}


extension MemoViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

