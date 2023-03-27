//
//  Routes.swift
//  google-identity-sign-in
//
//  Created by Aung Moe Hein on 20/03/2023.
//

import Foundation
import UIKit

class Routes {
    let Storyboard  = UIStoryboard(name: "Main", bundle: nil)
    
    private func markAsRoot(_ vc: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: vc)
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion:
        { completed in
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        })
        
        return
    }
    
    func goToHomePage(root: Bool = true, parentViewController: UIViewController?) {
        let view = Storyboard.instantiateViewController(withIdentifier: "home") as! HomeViewController
        
        if root {
            markAsRoot(view)
        }
        
        parentViewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func goToLoginPage(root: Bool = true, parentViewController: UIViewController?) {
        let view = Storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        
        if root {
            markAsRoot(view)
        }
        
        parentViewController?.navigationController?.pushViewController(view, animated: true)
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
