//
//  AppDelegate.swift
//  memoLittle
//
//  Created by 준킴 on 2017. 10. 12..
//  Copyright © 2017년 junebuug. All rights reserved.
//

import UIKit
import Intents
import RealmSwift
import memoCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let realm = try! Realm()
    var list : Results<Person>!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        list = realm.objects(Person.self)
        

        let memo = Memo.load()
        if memo.contents != "" {
            var writer = Person()
            let foundList = list.filter("name == [c]%@",memo.writer)
            if let person = foundList.first  {
                writer = person
            }else{
                writer.name = memo.writer
            }
            
            let obj = LittleLine()
            obj.objectName = memo.contents
            obj.personName = memo.writer
            obj.writer = writer
            obj.category = 0
            
            try! realm.write{
                realm.add(writer)
                realm.add(obj)
            }
        }
      
        if UserDefaults.standard.object(forKey: "themeNumber") != nil{
            let num = UserDefaults.standard.integer(forKey: "themeNumber")
            setTheme(selectedIndex: num)
        }
       
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor =  UIColor(red: 241.0/255.0,green: 241.0/255.0 ,blue: 239.0/255.0, alpha: 1.0)
        UISearchBar.appearance().barTintColor = Style.backgroundColor
        UISearchBar.appearance().tintColor =  Style.textColor
        UITabBar.appearance().tintColor = Style.tintColor
        UITabBar.appearance().backgroundColor = Style.backgroundColor
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    fileprivate func requestAuthorisation() {
        INPreferences.requestSiriAuthorization { status in
            if status == .authorized {
                print("Hey, Siri!")
            } else {
                print("Nay, Siri!")
            }
    }
    }
    
    func setTheme(selectedIndex : Int){
        if selectedIndex == 0 {
            Style.themeNormal()
        }else if selectedIndex == 1{
            Style.themeNight()
        }else if selectedIndex == 2{
            Style.themeTwitter()
        }else if selectedIndex == 3{
            Style.themeBlack()
        }else{
            Style.themeDribble()
        }
    }

}

