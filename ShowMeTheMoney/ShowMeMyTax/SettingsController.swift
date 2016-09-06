//
//  SettingsController.swift
//  ShowMeMyTax
//
//  Created by Dan Gerchcovich on 27/08/2016.
//  Copyright © 2016 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import MessageUI;
import AVFoundation;

import AudioToolbox;

public class SettingsController : UITableViewController, MFMailComposeViewControllerDelegate {

    let AISettings : [Int: String] = [0: "🔋 Battery Monitor"];
    let generalSettings : [Int: String] = [0:"📋 About",1:"📱 Share",2:"🔬 Report an issue", 3:"🤔 Send feedback"];

    
    var appDelegate : AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate;
    }
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return AISettings.count;
            break;
        default:
            return generalSettings.count;
            break;
        }
    }
    
    private func AutoCrashReport(title: String, message: String) -> Void {
        let autoCrashController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let confirmed = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:{(Action: UIAlertAction)-> Void in
            //sends automatic crash reports
        });
        
        let denied = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler:{(Action: UIAlertAction)->Void in
        });
        
        autoCrashController.addAction(confirmed);
        autoCrashController.addAction(denied);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(autoCrashController, animated: true, completion: {()->Void in
                let sound: SystemSoundID = SystemSoundID(4095);
                AudioServicesPlaySystemSound(sound);
            });
        }
        else {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion:{()-> Void in
                let sound : SystemSoundID = SystemSoundID(4095);
                AudioServicesPlaySystemSound(sound);
            });
        }
    }
    
    public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
            case 0:
                return "🔌 AI Settings";
                break;
            default:
                return "🔧 General Settings";
                break;
        }
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "settingsCell");
        tableView.allowsSelection = true;
        
        tableCell.textLabel?.adjustsFontSizeToFitWidth = true;
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            tableView.rowHeight = 100.0;
        }
        else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            tableView.rowHeight = 50.0;
        }
        
        
        switch(indexPath.section) {
        case 0: //AI settings
            tableCell.textLabel?.text = AISettings[indexPath.row];
            tableCell.textLabel?.textColor = UIColor.blackColor();
            tableCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
    
            return tableCell;
            break;
        default: //general settings
            tableCell.textLabel?.text = generalSettings[indexPath.row];
            tableCell.textLabel?.textColor = UIColor.blackColor();
            tableCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
            return tableCell;
            break;
        }
    }
    

    //general alert controllers
    
    private func enableBattery(title: String, message: String) ->Void {
        let enableBatteryController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let enabled = UIAlertAction(title: "Enable", style: UIAlertActionStyle.Default, handler:nil);
        let disabled = UIAlertAction(title: "Disable", style: UIAlertActionStyle.Cancel, handler: nil);

        enableBatteryController.addAction(enabled);
        enableBatteryController.addAction(disabled);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(enableBatteryController, animated:true, completion:nil);
        }
        else if(self.presentedViewController != nil) {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                self.presentViewController(enableBatteryController, animated: true, completion: nil);
            });
        }
    }
    
    
    //about controller
    private func aboutApp(title: String, message: String) ->Void {
        let aboutController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        aboutController.addAction(confirmed);
    
        
        if(self.presentedViewController == nil) {
            self.presentViewController(aboutController, animated:true, completion:nil);
        }
        else if(self.presentedViewController != nil) {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                self.presentViewController(aboutController, animated: true, completion: nil);
            });
        }
    }
    
    private func shareApp(title: String, message: String) ->Void {
        let shareController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let facebookOption = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: {(Action : UIAlertAction)-> Void in
            let facebookURL = NSURL(string: "https://www.facebook.com/"); //facebook URL
            if(UIApplication.sharedApplication().canOpenURL(facebookURL!) == true) {
                UIApplication.sharedApplication().openURL(facebookURL!);
            }
                //cannot direct end user to facebook page
            else {
                    let facebookProblemControl = UIAlertController(title: "😂 Cannot direct you to Facebook", message: "Seems that your device cannot be directed to Facebook. Please check your internet connection ", preferredStyle: .Alert);
                    
                    let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                    
                    facebookProblemControl.addAction(confirmed);
                    
                    if(self.presentedViewController == nil) {
                        self.presentViewController(facebookProblemControl, animated:true, completion:{()->Void in
                            let sound : SystemSoundID = SystemSoundID(4095);
                            AudioServicesPlaySystemSound(sound);
                        });
                    }
                    else if(self.presentedViewController != nil) {
                        self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                            self.presentViewController(facebookProblemControl, animated: true, completion: {() ->Void in
                                let sound : SystemSoundID = SystemSoundID(4095);
                                AudioServicesPlaySystemSound(sound);
                            });
                        });
                }
            }
        });
        
        
        let twitterOption = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: {(Action : UIAlertAction)-> Void in
            let twitterURL = NSURL(string: "https://twitter.com/"); //facebook URL
            if(UIApplication.sharedApplication().canOpenURL(twitterURL!) == true) {
                UIApplication.sharedApplication().openURL(twitterURL!);
            }
                //cannot direct end user to facebook page
            else {
                    let twitterProblemControl = UIAlertController(title: "😂 Cannot direct you to Twitter", message: "Seems that your device cannot be directed to Twitter. Please check your internet connection ", preferredStyle: .Alert);
                    
                    let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                
                    twitterProblemControl.addAction(confirmed);
                    
                    if(self.presentedViewController == nil) {
                        self.presentViewController(twitterProblemControl, animated:true, completion:{()->Void in
                            let sound : SystemSoundID = SystemSoundID(4095);
                            AudioServicesPlaySystemSound(sound);
                        });
                    }
                    else if(self.presentedViewController != nil) {
                        self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                            self.presentViewController(twitterProblemControl, animated: true, completion: {() ->Void in
                                let sound : SystemSoundID = SystemSoundID(4095);
                                AudioServicesPlaySystemSound(sound);
                            });
                        });
                    }
                }
        });
    
        let emailFriend = UIAlertAction(title: "Email a friend", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction)->Void in
            let mail : MFMailComposeViewController = MFMailComposeViewController();
            
            mail.mailComposeDelegate = self;
            if(MFMailComposeViewController.canSendMail() == true) {
                if(self.presentedViewController == nil) {
                    self.presentViewController(mail, animated: true, completion: nil);
                }
                else {
                    self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                        self.presentViewController(mail, animated: true, completion: nil);
                    });
                }
            }
            else {
                let AI : Utilities = Utilities();
                if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                        AI.englishAI("Cannot open message app. Check if you can send messages on your iPad");
                }
                
                else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                    AI.englishAI("Cannot open message app. Check if you can send messages on your iPhone");
                }
            }
            
            
        });
   
        
        let textFriend = UIAlertAction(title: "Text a friend", style: UIAlertActionStyle.Default, handler:{(Action : UIAlertAction)->Void in
            let text = NSURL(string: "sms:");
            if(UIApplication.sharedApplication().canOpenURL(text!) == true) {
                UIApplication.sharedApplication().openURL(text!);
            }
            else {
                let AI : Utilities = Utilities();
                if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                    AI.englishAI("Cannot open message app. Check if you can send messages on your iPad");
                }
                    
                else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                    AI.englishAI("Cannot open message app. Check if you can send messages on your iPhone");
                }
            }
        });
        
        let denied = UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.Cancel, handler: nil);

        
        
        shareController.addAction(facebookOption);
        shareController.addAction(twitterOption);
        shareController.addAction(emailFriend);
        shareController.addAction(textFriend);
        shareController.addAction(denied);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(shareController, animated:true, completion:nil);
        }
        else if(self.presentedViewController != nil) {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                self.presentViewController(shareController, animated: true, completion: nil);
            });
        }
    }
    
    private func errorMail(title: String, message: String) ->Void {
        let errorController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        errorController.addAction(confirmed);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(errorController, animated: true, completion: nil);
        }
        else {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {() -> Void in
                self.presentViewController(errorController, animated: true, completion: nil);
            })
        }
    }
    
    public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        if(result == MFMailComposeResultCancelled) {
            controller.dismissViewControllerAnimated(true, completion: {()->Void in
                let mailCancel : SystemSoundID = SystemSoundID(4095);
                AudioServicesPlaySystemSound(mailCancel);
            });
        }
        else if(result == MFMailComposeResultFailed) {
            let voice : Utilities = Utilities();
            if(error == NSURLErrorNotConnectedToInternet) {
                if(controller.isBeingDismissed()) {
                    voice.englishAI("Failed to send message because you are not connected to the internet");
                    errorMail("No internet connection", message: "Cannot send email because you have no internet connection");
                }
            }
                voice.englishAI("Error failed to send message.");
        }
     }
    
    private func reportIssue(title: String, message: String) ->Void {
        let reportController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let confirmed = UIAlertAction(title: "Send Report", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction)->Void in
            let sendMail : MFMailComposeViewController = MFMailComposeViewController();
            
            sendMail.mailComposeDelegate = self;
            if(MFMailComposeViewController.canSendMail() == true) {
                if(self.presentedViewController == nil) {
                    self.presentViewController(sendMail, animated: true, completion: nil);
                }
                else {
                    self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                        self.presentViewController(sendMail, animated: true, completion: nil);
                    });
                }
            }
            else {
                let AI : Utilities = Utilities();
                if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                    AI.englishAI("Cannot open message app. Check if you can send messages on your iPad");
                }
                    
                else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                    AI.englishAI("Cannot open message app. Check if you can send messages on your iPhone");
                }
            }
        });
    
        
        let denied = UIAlertAction(title: "Never Mind", style: UIAlertActionStyle.Cancel, handler: nil);
        
        reportController.addAction(confirmed);
        reportController.addAction(denied);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(reportController, animated:true, completion:nil);
        }
        else if(self.presentedViewController != nil) {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                self.presentViewController(reportController, animated: true, completion: nil);
            });
        }
    }
    
    private func sendFeedback(title: String, message: String) ->Void {
        let reportController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let confirmed = UIAlertAction(title: "Send Feedback?", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction)->Void in
            let sendMail : MFMailComposeViewController = MFMailComposeViewController();
            
            
            sendMail.mailComposeDelegate = self;
            if(MFMailComposeViewController.canSendMail() == true) {
                if(self.presentedViewController == nil) {
                    self.presentViewController(sendMail, animated: true, completion: nil);
                }
                else {
                    self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                        self.presentViewController(sendMail, animated: true, completion: nil);
                    });
                }
            }
            else {
                let AI : Utilities = Utilities();
                if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                    AI.englishAI("Cannot open message app. Check if you can send messages on your iPad");
                }
                    
                else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                    AI.englishAI("Cannot open message app. Check if you can send messages on your iPhone");
                }
            }
        });
        
        
        let denied = UIAlertAction(title: "Never Mind", style: UIAlertActionStyle.Cancel, handler: nil);
        
        reportController.addAction(confirmed);
        reportController.addAction(denied);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(reportController, animated:true, completion:nil);
        }
        else if(self.presentedViewController != nil) {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                self.presentViewController(reportController, animated: true, completion: nil);
            });
        }
    }
    
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section) {
        case 0: //AI settings
            if(indexPath.row == 0) {
                //present an alert controller that enables or disables the battery monitor
                if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                    enableBattery("Enable battery monitor?", message: "The battery monitor notifies you if your iPad is running low on battery");
                }
                else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                    enableBattery("Enable battery monitor?", message: "The battery monitor notifies you if your iPhone is running low on battery");
                }
            }
            break;
        default: //general settings
            switch(indexPath.row) {
            case 0: //about
                aboutApp("Welcome to ShowMeMyTax", message: "This app serves as an income tax calculator that calculates how much tax you will pay as an employee. It then categorizes this amount into a yearly, monthly, daily, and hourly pay, based on the tax laws of 4 of the major countries around the world");
                break;
            case 1: //share
                shareApp("Tell your friends", message: "Tell your friends about this app. Share it on facebook, twitter, or just text who you think might find this app useful.");
                break;
            case 2: //report an issue
                reportIssue("Any problems?", message: "Email me, so I can resolve your issues as soon as possible");
                break;
            case 3: //send feedback
                sendFeedback("Any suggestions?", message: "If you have any suggestions as to how I could improve this app then do not hesitate to email me some feedback. This will help me to improve the user experience of other users.");
                break;
            default: //send automatic crash reports
                print("No Selection made");
                break;
            }
            break;
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
    public override func viewDidLoad() {
     
        self.view.backgroundColor = UIColor.whiteColor();
        self.tableView.backgroundColor = UIColor.whiteColor();
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length, 0);
        
        self.appDelegate.tabController.tabBar.translucent = true;
        
        
        
    }
}