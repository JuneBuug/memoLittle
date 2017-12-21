//
//  TextSizeViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 12. 21..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit

class TextSizeViewController: UIViewController {

    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        let fontSize = Int(sender.value)
        sampleLabel.font = UIFont(name : sampleLabel.font.fontName, size: CGFloat(fontSize))
    }
    
    @IBAction func onCloseBtn(_ sender: Any) {
        Style.fontSize = slider.value
        NotificationCenter.default.post(name: NSNotification.Name("updateTheme"), object: nil)
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

}
