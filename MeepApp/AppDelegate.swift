//
//  AppDelegate.swift
//  MeepApp
//
//  Created by Sergio Castillo on 19/12/2020.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyCu54fW8_YjdHG9n0gSPrdUW-Y5OXf0Uyk")
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.configureMainInterface(in: window)
        
        self.window = window
        
        return true
    }
}

