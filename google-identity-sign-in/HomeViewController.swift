//
//  HomeViewController.swift
//  google-identity-sign-in
//
//  Created by Aung Moe Hein on 17/03/2023.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import AmitySDK

class HomeViewController: UIViewController {
    @IBOutlet weak var logout: UIButton!
    var token: AmityNotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            GIDSignIn.sharedInstance.signOut()
            try Auth.auth().signOut()
            AppManager.shared.logout()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

}
