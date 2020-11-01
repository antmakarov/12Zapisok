//
//  AppDelegate.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
                
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Logger.mark()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Logger.mark()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Logger.mark()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Logger.mark()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Logger.mark()
    }
}
