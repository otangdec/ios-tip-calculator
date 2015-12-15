//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Oranuch on 12/9/15.
//  Copyright © 2015 Oranuch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //set tip percentages first time
        NSUserDefaults.standardUserDefaults().setObject(["Good":0.18, "Great":0.20, "Excellent":0.22], forKey: "servicePercentDict")
        
        //set the default currency
        NSUserDefaults.standardUserDefaults().setValue("USD", forKey: "selectedCurrency")
        
        //clear bill amount across applicaiton
        let nowDate = NSDate().dateByAddingTimeInterval(10*60)
        let timer = NSTimer(fireDate: nowDate, interval: 0, target: self, selector: "resetBillAmount", userInfo: nil, repeats: false)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        return true
    }
    
    func resetBillAmount() {
        if var billAmount = NSUserDefaults.standardUserDefaults().valueForKey("billAmount") {
            billAmount = 0.0
            NSUserDefaults.standardUserDefaults().setValue(billAmount, forKey: "billAmount")
        }
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

