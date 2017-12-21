//
//  SettingsViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 26..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    var list  = ["접근성 설정","테마 설정","앱정보"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: NSNotification.Name("updateTheme"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func setupUI(){
        self.view.backgroundColor = Style.backgroundColor
        self.tableView.backgroundColor = Style.backgroundColor
        navBar.barTintColor = Style.backgroundColor
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Style.textColor]
        tableView.reloadData()
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

extension SettingsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.textColor = Style.textColor
        cell.backgroundColor = Style.backgroundColor
        cell.accessoryView?.tintColor = Style.textColor
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ThemeSelectViewController") as! ThemeSelectViewController
            self.show(vc, sender: nil)
        }
    }
    
}
