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
    var list = ["뫄뫄","준킴","탐"]
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.register(UINib(nibName: "LittleLineLikeTableViewCell", bundle: nil), forCellReuseIdentifier: "LittleLineLikeTableViewCell")
        tableView.register(UINib(nibName: "LittleLineEventTableViewCell", bundle: nil), forCellReuseIdentifier: "LittleLineEventTableViewCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive
    }
    

}

extension LittleLineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return 5;
        }else{
            return list.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isFiltering(){
            return UITableViewCell()
        }else{
            if indexPath.row % 2 == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineLikeTableViewCell",for: indexPath) as! LittleLineLikeTableViewCell
                cell.personName.text? = list[indexPath.row]
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "LittleLineEventTableViewCell",for: indexPath) as! LittleLineEventTableViewCell
                cell.personName.text? = list[indexPath.row]
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
}

extension LittleLineViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
     
    }
}
