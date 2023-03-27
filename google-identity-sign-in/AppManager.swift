//
//  AppManager.swift
//  google-identity-sign-in
//
//  Created by Aung Moe Hein on 17/03/2023.
//

import Foundation
import AmitySDK

class MySessionHandler: SessionHandler {
    func sessionWillRenewAccessToken(renewal: AccessTokenRenewal) {
        renewal.renew()
    }
}

class AppManager {
    static let shared = AppManager()
    private var apiKey = "<YOUR_AMITY_API_KEY>"
    private var client: AmityClient!
    private var userId: String?
    
    private init() {
        print("HEREEEEEE")
        client = try? AmityClient(apiKey: apiKey, region: .US)
    }
    
    private func login(_ displayName: String? = nil, completion: AmityRequestCompletion? = nil) {
        guard userId != nil else {return}
        
        Task { @MainActor in
            do {
                try await client.login(
                    userId: userId!,
                    displayName: displayName,
                    authToken: nil,
                    sessionHandler: MySessionHandler()
                )
                completion?(true, nil)
            } catch {
                completion?(false, error)
            }
        }
    }
    
    func getClient() -> AmityClient {
        return self.client
    }
    
    func getSessionState() -> SessionState {
        return client.sessionState
    }
    
    func getUserId() -> String? {
        return userId
    }
    
    func setUserId(_ userId: String?) {
        self.userId = userId
    }
    
    public func logout() {
        self.client.logout()
        Routes().goToLoginPage(parentViewController: nil)
    }
    
    public func amityLogin() {
        self.login() {
            success, error in
            print("[google-identity-sign-in App] register device with userId '\(self.userId ?? "")' \(success ? "successfully" : "failed")")
            if let error = error {
                print("[google-identity-sign-in App] register device failed \(error.localizedDescription)")
            }
            
            Routes().goToHomePage(parentViewController: nil)
        }
    }
}
