//
//  AddPersonViewController.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 18..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit
import RealmSwift

class AddPersonViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 사람 정보 수정 View로 적용

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var relationship: UITextView!
    @IBOutlet weak var relationshipNameLabel: UILabel!
    let realm = try! Realm()
    var user : Person?
    var notificationToken: NotificationToken!
    var personList: Results<Person>!
    var newPhoto = Photo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateUI()
        setupUI()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(tapGestureRecognizer)
        personList = realm.objects(Person.self)
        notificationToken = personList.addNotificationBlock({ (change) in
            self.updateUI()
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: NSNotification.Name("updateTheme"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can bse recreated.
    }
    
    @objc func setupUI(){
        self.view.backgroundColor = Style.backgroundColor
        textView.backgroundColor = Style.backgroundColor
        mainView.backgroundColor = Style.backgroundColor
        saveBtn.titleLabel?.textColor = Style.tintColor
        closeBtn.tintColor = Style.tintColor
        textView.textColor = Style.textColor
        relationship.backgroundColor = Style.backgroundColor
        relationship.textColor = Style.textColor
        nickNameLabel.textColor = Style.tintColor
        relationshipNameLabel.textColor = Style.tintColor
        
    }
    
    func updateUI(){
        if let person = user{ // 맨처음에 UI가 nil이 아닐 경우에만
            textView.text = person.name
            relationship.text = person.relationship
            
            if let profile = person.profile.image {
                profilePicture.image = UIImage(data:profile)
            }
            profilePicture.layer.borderWidth = 0
            profilePicture.layer.masksToBounds = false
            profilePicture.layer.cornerRadius = profilePicture.frame.height/2
            profilePicture.clipsToBounds = true
        }
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        newPhoto.image = UIImageJPEGRepresentation(selectedImage, 0.01)
        profilePicture.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchWrite(_ sender: Any) {
        // 사람 정보를 수정
        // Query and update from any thread
        let name = self.textView.text!
        let relationship = self.relationship.text!
        let personRef = ThreadSafeReference(to: user!)
      
        // thread conflict 제거용
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                guard let person = realm.resolve(personRef) else {
                    return // person was deleted
                }
                try! realm.write {
                    person.profile = self.newPhoto
                    person.name = name
                    person.relationship = relationship
                }
            }
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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

}
