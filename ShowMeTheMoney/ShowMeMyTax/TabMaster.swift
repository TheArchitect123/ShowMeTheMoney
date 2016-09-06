//
//  TabMaster.swift
//  ShowMeMyTax
//
//  Created by Dan Gerchcovich on 27/08/2016.
//  Copyright © 2016 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;
import CoreGraphics;
import AVFoundation;

public class TabMaster : UITabBarController, UITabBarControllerDelegate, UITextFieldDelegate {
    var taxVar = CalculateTaxMain();
    let AI : Utilities = Utilities();
    
    @IBOutlet var TabMasterBar: UITabBar! = UITabBar();
    var barButton : UIBarButtonItem = UIBarButtonItem();
    
    var appsDelegate : AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate;
        }
    }
    
    public override func viewDidAppear(animated: Bool) {
    }
    
    @objc private func instructions() {
        let instructionsController = UIAlertController(title: "Welcome \(UIDevice.currentDevice().name).", message: "Here you can calculate your income tax as an employee based on this year's current income tax laws of the 4 major countries around the world. Simply choose the country that you reside in and press calculate when you are ready to get started. The table below contains tax options that you can apply, based on your situation, that will affect your calculated income after tax", preferredStyle: UIAlertControllerStyle.Alert);
        
        let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        instructionsController.addAction(confirmed);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(instructionsController, animated: true, completion: nil);
        }
        else {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                self.presentViewController(instructionsController, animated: true, completion: {()->Void in
                    let utility = Utilities();
                    utility.englishAI("Welcome \(UIDevice.currentDevice().name). Thank you for downloading this application. In this application you can calculate your income tax as an employee. Simply choose your country that you work in and press calculate when you are ready to get started");
                });
            });
        }
    }
    
    public override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.lightTextColor();
        
        
        instructions();
        
        let settingsControl = SettingsController();
        let taxCalculateControl = CalculateTaxMain();
        //let sampleController = SampleController();
        
        
        appsDelegate.tabController = self;
        
        self.setViewControllers([taxCalculateControl, settingsControl], animated: true);
        
        self.tabBar.hidden = false;
        self.tabBar.barStyle = UIBarStyle.Default;

        
        //adjust the frame of the tab bar depending on the size and type of device
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            if(UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.LandscapeLeft || UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.LandscapeRight) {
                
                //table sizes
                let screenSizeWidth = UIScreen.mainScreen().bounds.width;
                let screenSizeHeight = UIScreen.mainScreen().bounds.height / 16.0;
               
        
                
            }
            else if(UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.Portrait || UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.PortraitUpsideDown) {
                let screenSizeWidth = UIScreen.mainScreen().bounds.width;
                let screenSizeHeight = UIScreen.mainScreen().bounds.height / 16.0;
             
            
                
            }
        }
        
        else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            //table sizes
            let screenSizeWidth = UIScreen.mainScreen().bounds.width;
            let screenSizeHeight = UIScreen.mainScreen().bounds.height / 16.0;
    
        }
        
        self.tabBar.tintColor = UIColor.redColor();
        self.tabBar.translucent = true;
        
        self.tabBar.items![0].title = "Tax";
        self.tabBar.items![1].title = "Settings";
        
        //unselected images
        
        self.tabBar.items![0].image = UIImage(named: "UnSelectedImageCalc.png");
        self.tabBar.items![1].image = UIImage(named: "SettingsUnselected2.png");
        
        //selected images 
        
        self.tabBar.items![0].selectedImage = UIImage(named: "SelectedImageCalc.png");
        self.tabBar.items![1].selectedImage = UIImage(named: "SettingsSelected2.png");
        
        
        self.barButton.customView = taxCalculateControl.button;
        print("Tab Bar Controller: \(self)");
        print("Number of items on controller: \(self.tabBar.items?.count)");
        
        self.delegate = self;
        self.navigationItem.setRightBarButtonItem(self.barButton, animated: true);
        
        let infoButton = UIButton(type: UIButtonType.InfoLight);
        infoButton.frame = CGRect(x: 0, y: 20, width: 40, height: 40);
        infoButton.addTarget(self, action: #selector(self.instructions), forControlEvents: UIControlEvents.TouchDown);
        infoButton.showsTouchWhenHighlighted = true;
        
        let infoBarButton = UIBarButtonItem();
        infoBarButton.customView = infoButton;
        
        self.navigationItem.setLeftBarButtonItem(infoBarButton, animated: false);
        
        self.navigationItem.title = "Tax Calculator";
        
    }
    
    public func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let tabCalculate : CalculateTaxMain = CalculateTaxMain();
        let tabSettings : SettingsController = SettingsController();
        
        switch(tabBarController.selectedIndex) {
        case 0: //main page
            self.navigationItem.setRightBarButtonItem(self.barButton, animated: false);
            let infoButton = UIButton(type: UIButtonType.InfoLight);
            infoButton.frame = CGRect(x: 0, y: 20, width: 40, height: 40);
            infoButton.addTarget(self, action: #selector(self.instructions), forControlEvents: UIControlEvents.TouchDown);
            infoButton.showsTouchWhenHighlighted = true;
            
            let infoBarButton = UIBarButtonItem();
            infoBarButton.customView = infoButton;
            
            self.navigationItem.setLeftBarButtonItem(infoBarButton, animated: false);
            
            
            self.navigationItem.title = "Tax Calculator";
            
            break;
        case 1: //settings page
            self.navigationItem.setLeftBarButtonItem(nil, animated: false);
            self.navigationItem.setRightBarButtonItem(nil, animated: false);
            
            self.navigationItem.title = "Settings";
            break;
        default:
            print("No tab bar item selected");
            break;
        }
        
    }
}
