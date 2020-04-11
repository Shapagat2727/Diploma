//
//  Extensions.swift
//  Diploma
//
//  Created by Шапагат on 4/4/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SwiftyUserDefaults

public extension Object {
    func toDictionary() -> NSDictionary {
        let properties = self.objectSchema.properties.map { $0.name }
        let dictionary = self.dictionaryWithValues(forKeys: properties)
        
        let mutabledic = NSMutableDictionary()
        mutabledic.setValuesForKeys(dictionary)
        
        for prop in (self.objectSchema.properties as [Property]?)! {
            // find lists
            if prop.objectClassName != nil  {
                if let nestedObject = self[prop.name] as? Object {
                    mutabledic.setValue(nestedObject.toDictionary(), forKey: prop.name)
                } else if let nestedListObject = self[prop.name] as? ListBase {
                    var objects = [AnyObject]()
                    for index in 0..<nestedListObject._rlmArray.count  {
                        if let object = nestedListObject._rlmArray[index] as? Object {
                            objects.append(object.toDictionary())
                        }
                    }
                    mutabledic.setObject(objects, forKey: prop.name as NSCopying)
                }
            }
        }
        return mutabledic
    }
}
public extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
//extension UserDefaults{
//
//    //MARK: Check Login
//    func setLoggedIn(value: Bool) {
//        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
//        //synchronize()
//    }
//
//    func isLoggedIn()-> Bool {
//        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
//    }
//
//    //MARK: Save User Data
//    func setUserID(value: String){
//        set(value, forKey: UserDefaultsKeys.userID.rawValue)
//        //synchronize()
//    }
//    func setUserName(value: String){
//        set(value, forKey: UserDefaultsKeys.name.rawValue)
//        //synchronize()
//    }
//    func setUserSurname(value: String){
//        set(value, forKey: UserDefaultsKeys.surname.rawValue)
//        //synchronize()
//    }
//    func setUserStatus(value: String){
//        set(value, forKey: UserDefaultsKeys.status.rawValue)
//        //synchronize()
//    }
//
//    //MARK: Retrieve User Data
//    func getUserID() -> String{
//        return String(UserDefaultsKeys.userID.rawValue)
//    }
//    func getUserName() -> String{
//        return String(UserDefaultsKeys.name.rawValue)
//    }
//    func getUserSurname() -> String{
//        return String(UserDefaultsKeys.surname.rawValue)
//    }
//    func getUserStatus() -> String{
//        return UserDefaultsKeys.status.rawValue
//    }
//}
//enum UserDefaultsKeys : String {
//    case isLoggedIn
//    case userID
//    case name
//    case surname
//    case status
//}
enum UserCase{
    case teacher, student
}



//class Switcher {
//    
//    static func updateRootVC(){
//        
//        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
//        let status = UserDefaults.standard.string(forKey: "status")
//        var rootVC : UIViewController?
//       
//            print(status)
//        
//        if (isLoggedIn == true){
//            if(status! == "student"){
//                print("Hey")
//                rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarvc")
//                
//            }
//            if(status! == "teacher"){
//                rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navbarvc")
//            }
//        }
//        else{
//            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginvc") as! LoginViewController
//        }
//        
//        print("!!!!!!!!")
//        if let rvc = rootVC{
//            print(rvc)
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = rvc
//            appDelegate.window?.makeKeyAndVisible()
//            
//        }
//        
//        print(rootVC)
//    }
//    
//}
