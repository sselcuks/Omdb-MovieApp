//
//  Splash.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 24.03.2022.
//

import Foundation
import UIKit
import FirebaseRemoteConfig
import Reachability

class SplashVC: UIViewController{
    let reachability = try! Reachability()
    let remoteConfig = RemoteConfig.remoteConfig()
    
    @IBOutlet weak var splashTitle: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        fetchVal()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkError()
    }
    
    func fetchVal(){
        
        let defaults: [String: NSObject] = [
            "show_splash_ui": "Loodos" as NSObject
        ]
        remoteConfig.setDefaults(defaults)
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        let cachedVal = self.remoteConfig.configValue(forKey: "show_splash_ui").stringValue
        
        self.remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success, error == nil {
                
                self.remoteConfig.activate { success, error in
                    guard error == nil else {
                        
                        return
                    }
                    //let value = self.remoteConfig.configValue(forKey: "show_splash_ui").stringValue
                    DispatchQueue.main.async {
                        self.splashTitle.text = cachedVal
                    }
                    
                }
            }
        }
    }
    deinit {
        reachability.stopNotifier()
    }
    
}
extension SplashVC{
    func networkError(){
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    
                } else {
                    
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.performSegue(withIdentifier: "MovieVc", sender: nil)
                    
                }
            }
            self.reachability.whenUnreachable = { _ in
                if let alertVc = self.storyboard?.instantiateViewController(withIdentifier: "NetworkError") as? NetworkError {
                    alertVc.modalPresentationStyle = .overFullScreen
                    self.present(alertVc, animated: true)
                }
                
            }
            
            do {
                try self.reachability.startNotifier()
            } catch {
                
            }
        }
    }
    
}
