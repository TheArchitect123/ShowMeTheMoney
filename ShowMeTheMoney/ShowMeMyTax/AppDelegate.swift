//
//  AppDelegate.swift
//  ShowMeMyTax
//
//  Created by Dan Gerchcovich on 27/08/2016.
//  Copyright © 2016 Dan Gerchcovich. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var tabController : UITabBarController = UITabBarController();
    
    
    
    //australian tax 
    public var isTaxFreeThreshold : Bool = false;
    public var isSuperAnnuation : Bool = false;
    public var isNonResident : Bool = false;
    public var isHELP_TSL : Bool = false;
    public var isStudentLoan : Bool = false;
    public var isTaxOffsets : Bool = false;
    
    public var australianFilters : [String] = []; 
    
    public var symbolCurrency : String = "$";
    
    //gross income
    public var yearlyIncome : Double = 0;
    public var monthlyIncome : Double = 0;
    public var weeklyIncome : Double = 0;
    public var dailyIncome : Double = 0;
    public var hourlyIncome : Double = 0;
    
    //taxed income
    public var yearlyTaxed : Double = 0;
    public var monthlyTaxed : Double = 0;
    public var weeklyTaxed : Double = 0;
    public var dailyTaxed : Double = 0;
    public var hourlyTaxed : Double = 0;
    
    //income after tax.  This flushed to the screen
    public var yearlyAfterTaxed : Double = 0;
    public var monthlyAfterTaxed : Double = 0;
    public var weeklyAfterTaxed : Double = 0;
    public var dailyAfterTaxed : Double = 0;
    public var hourlyAfterTaxed : Double = 0;
    
  
    //AMERICAN TAX PROPERTIES
    public var isChildDependency : Bool = false;
    public var isLifetimeLearning : Bool = false;
    public var isSaversCredit : Bool = false;
    public var isEarnedIncome : Bool = false;
    
    
    //CHINESE TAX PROPERTIES 
    public var isRoyaltyIncome : Bool = false;
    public var isSmallBusinessExpenses : Bool = false;
    public var isRentalIncome : Bool = false;
    public var isLabourServices : Bool = false;
    
    //ENGLISH TAX PROPERTIES
    public var isDividends : Bool = false;
    public var isMarriage : Bool = false;
    public var isInheritance : Bool = false;
    
    
    //write the rest of the properties here.All the memory in this app wiull be controlled inside the application's delegate class to stop ARC from touching it
    
    var window: UIWindow?
    //public var switchObject : UISwitch = UISwitch();

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if #available(iOS 8.0, *) {
            //device is currently up to date with the iOS 8.0 or above
            
            //start upt the push notifications
            
            let notifications = UIUserNotificationSettings.init(forTypes: UIUserNotificationType.Alert, categories: nil);
            UIApplication.sharedApplication().registerUserNotificationSettings(notifications);
            
            //push notifications
            
            //battery level
            let batteryNotificationLevel : UILocalNotification = UILocalNotification();
            batteryNotificationLevel.category = UIDeviceBatteryLevelDidChangeNotification;
            
            UIApplication.sharedApplication().scheduleLocalNotification(batteryNotificationLevel);
            
            return true;
        }
        else {
            //device is not up to date
            let utility : Utilities = Utilities();
            if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                utility.englishAI("Seems that iPhone does not contain the latest iOS. You need at least iOS 8 or above to run this app. Have a nice day");
                return false;
            }
            else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                utility.englishAI("Seems that iPhone does not contain the latest iOS. You need at least iOS 8 or above to run this app. Have a nice day");
                return false;
            }
        }
        return false;
    }

    
   /*func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone){
            return UIInterfaceOrientationMask.Portrait;
        }
        else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            return UIInterfaceOrientationMask.Portrait;
    }
    return UIInterfaceOrientationMask.Portrait;
}
    */
    
   func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    //performs battery actions everytime the local notifications are scheduled based on the notification events (category)
        let utility : Utilities = Utilities();
        utility.batteryLevel(true);
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

