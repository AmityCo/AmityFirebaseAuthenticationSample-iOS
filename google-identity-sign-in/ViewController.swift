//
//  ViewController.swift
//  google-identity-sign-in
//
//  Created by Aung Moe Hein on 16/03/2023.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        switch AppManager.shared.getSessionState() {
        case .notLoggedIn, .establishing:
            Routes().goToLoginPage(root: false, parentViewController: self)
        case .established, .tokenExpired:
            Routes().goToHomePage(root: false, parentViewController: self)
        case .terminated(let error):
            print("GO TO USER BAN", error)
        }
    }
    
//    func checkGoogleLogin() {
//        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//            if error != nil || user?.userID == nil {
//                // Go to Login Page
//                print("Error", error?.localizedDescription)
//                Routes().goToLoginPage(root: false, parentViewController: self)
//            } else {
//                // Go to Home Page
//                AppManager.shared.setUserId(user?.userID!)
//                AppManager.shared.amityLogin()
//            }
//        }
//    }
}

