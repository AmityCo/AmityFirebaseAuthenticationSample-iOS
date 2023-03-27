//
//  LoginViewController.swift
//  google-identity-sign-in
//
//  Created by Aung Moe Hein on 17/03/2023.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    @IBOutlet weak var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func addUserToFirestore(_ result: AuthDataResult?) {
        let db = Firestore.firestore()
        db.collection("user").document(String((result?.user.uid)!)).setData([
            "id" : String((result?.user.uid)!),
            "displayName" : (result?.user.displayName)!,
            "photoURL" : (result?.user.photoURL)!,
            "points" : 0,
            "knownLanguageCodes" : []
        ], merge: true)
    }
    
    func firebaseAuthSignIn(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { result, error in
            if result?.additionalUserInfo?.isNewUser ?? false {
                self.addUserToFirestore(result)
            }
            
            AppManager.shared.amityLogin()
        }
    }
    
    @IBAction func btnSIgnIn(_ sender: Any) {
        let signInConfig = GIDConfiguration.init(clientID: "<YOUR_GOOGLE_CLIENT_ID>")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil || user == nil else { return }
            
            AppManager.shared.setUserId(user?.userID!)
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: user?.authentication.idToken ?? "" ,
                accessToken: user?.authentication.accessToken ?? ""
            )
            
            self.firebaseAuthSignIn(credential: credential)
          }
    }
}
