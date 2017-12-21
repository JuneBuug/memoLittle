//
//  LittleLineViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 13..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class LittleLineViewController: UIViewController {

    @IBOutlet weak var titleItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var list : Results<LittleLine>!
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    var filtered_list : Results<LittleLine>!
    
    let searchController = UISearchController(searchResultsController: nil)

    @IBAction func onTouchTTSBtn(_ sender: Any) {
        let synthesizer = AVSpeechSynthesizer()
        
        let str = "샘플입니다."
//        let str = "오늘은" + list[0].personName + "님에게 " + list[0].objectName + "를 해주시는 건 어떨까요?"
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        
        synthesizer.speak(utterance)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Realm init
        setupRealm()
        list = realm.objects(LittleLine.self)
        notificationToken = list.addNotificationBlock({ (change) in
            self.tableView.reloadData()
        })
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "이름 혹은 대상으로 검색해보세요."
        searchController.searchBar.setValue("취소", forKey:"_cancelButtonText")

        tableView.register(UINib(nibName: "LittleLineLikeTableViewCell", bundle: nil), forCellReuseIdentifier: "LittleLineLikeTableViewCell")
        tableView.register(UINib(nibName: "LittleLineEventTableViewCell", bundle: nil), forCellReuseIdentifier: "LittleLineEventTableViewCell")
        
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

    func setupRealm() {
        // Log in existing user with username and password
        do {
            realm = try Realm()
        } catch {
            print("\(error)")
        }
    }
    
    deinit {
        notificationToken.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
      
        filtered_list = realm.objects(LittleLine.self).filter("personName CONTAINS[c]%@ OR objectName CONTAINS[c]%@",searchText,searchText)

        tableView.reloadData()
    }
    
}

extension LittleLineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filtered_list.count;
        }else{
            return list.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isFiltering(){
            
            if filtered_list[indexPath.row].category == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineLikeTableViewCell",for: indexPath) as! LittleLineLikeTableViewCell
//                cell.personName.text? = (filtered_list[indexPath.row].writer?.name)!
                cell.likeObject.text? = filtered_list[indexPath.row].objectName
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineEventTableViewCell",for: indexPath) as! LittleLineEventTableViewCell
//                cell.personName.text? = (filtered_list[indexPath.row].writer?.name)!
                cell.eventLabel.text? = filtered_list[indexPath.row].objectName
                return cell
            }
        }else{
            if list[indexPath.row].category == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineLikeTableViewCell",for: indexPath) as! LittleLineLikeTableViewCell
//                cell.personName.text? = (list[indexPath.row].writer?.name)!
                cell.likeObject.text? = list[indexPath.row].objectName
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineEventTableViewCell",for: indexPath) as! LittleLineEventTableViewCell
//                cell.personName.text? = (list[indexPath.row].writer?.name)!
                cell.eventLabel.text? = list[indexPath.row].objectName
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // realm delete
        let deleteAction = UITableViewRowAction(style: .destructive, title: "삭제") { (deleteAction, indexPath) in
            do {
                try self.realm.write {
                    self.realm.delete(self.list[indexPath.row])
                }
            } catch {
                print("\(error)")
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "편집") { (editAction, indexPath) in
//            self.alertForAlbumTitle(albumToBeUpdated: self.albums[indexPath.row])
        }
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 들어갈때 selected 된 걸 풀어줘야함
        tableView.deselectRow(at: indexPath, animated: false)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WriteViewController") as! WriteViewController
//        self.present(vc, animated: true, completion: nil)
    }
}

extension LittleLineViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


