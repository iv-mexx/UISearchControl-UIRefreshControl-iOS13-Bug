//
//  AppDelegate.swift
//  SearchPlusRefresh
//
//  Created by Markus Chmelar on 22.08.19.
//  Copyright © 2019 Innovaptor. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UINavigationBar.appearance().isTranslucent = false
    return true
  }
}

