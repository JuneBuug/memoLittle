//
//  ThemeSelectViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 12. 20..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class ThemeSelectViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    var list = ["기본테마 : Default Theme","한밤 테마 : MidNight Theme","트위터 테마 : Twitter Theme","블랙 테마 : Black Theme","드리블 테마: Dribbble Theme","숲속 테마 : Woods Theme"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: NSNotification.Name("updateTheme"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @objc func setupUI(){
        self.view.backgroundColor = Style.backgroundColor
        self.tableView.backgroundColor = Style.backgroundColor
        navBar.barTintColor = Style.backgroundColor
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Style.textColor]
        
        if let items = navBar.items {
            for item in items {
                item.rightBarButtonItem?.tintColor = Style.tintColor
                item.leftBarButtonItem?.tintColor = Style.tintColor
                item.backBarButtonItem?.tintColor = Style.tintColor
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func onSaveBtn(_ sender: Any) {
        
        if selectedIndex == 0 {
            Style.themeNormal()
        }else if selectedIndex == 1{
            Style.themeNight()
        }else if selectedIndex == 2{
            Style.themeTwitter()
        }else if selectedIndex == 3{
            Style.themeBlack()
        }else if selectedIndex == 4{
            Style.themeDribble()
        }else{
            Style.themeWoods()
        }
        UserDefaults.standard.set(selectedIndex,forKey:"themeNumber")
        
        NotificationCenter.default.post(name: NSNotification.Name("updateTheme"), object: nil)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}


extension ThemeSelectViewController : UITableViewDelegate,UITableViewDataSource{
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .none
        cell.selectionStyle = .none
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.textColor = Style.textColor
        cell.backgroundColor = Style.backgroundColor
        cell.accessoryView?.tintColor = Style.textColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
         tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }

}
