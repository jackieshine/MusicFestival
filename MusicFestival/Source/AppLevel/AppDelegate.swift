//
//  AppDelegate.swift
//  MusicFestival
//
//  Created by Jackie on 30/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    let viewController = HomeViewController()
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
    return true
  }
}

