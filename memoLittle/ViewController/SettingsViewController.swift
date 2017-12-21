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
    var list  = ["접근성 설정 Accessibility","테마 설정 Theme Settings","의견 제출 Submit Feedback", "앱정보 About"]
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if indexPath.row == 0 { // 접근성 설정
            let vc = storyboard.instantiateViewController(withIdentifier: "TextSizeViewController") as! TextSizeViewController
            self.show(vc, sender: nil)
        }else if indexPath.row == 1 { // 테마 설정
            let vc = storyboard.instantiateViewController(withIdentifier: "ThemeSelectViewController") as! ThemeSelectViewController
            self.show(vc, sender: nil)
        }else if indexPath.row == 2 { // 의견 제출
            let alert = UIAlertController(title: "의견 Feedback", message: "MemoLittle에 대한 의견을 적어주세요. Submit your free thoughts about memoLittle.", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = ""
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "전송 Send", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                Network.dataPost(text:(textField?.text)!)
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        }else { // 앱 정보
            let vc = storyboard.instantiateViewController(withIdentifier: "AppInfoViewController") as! AppInfoViewController
            self.show(vc, sender: nil)
        }
    }
    
}
