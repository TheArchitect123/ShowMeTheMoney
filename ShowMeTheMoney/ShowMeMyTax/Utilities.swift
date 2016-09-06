//
//  Utilities.swift
//  ShowMeMyTax
//
//  Created by Dan Gerchcovich on 27/08/2016.
//  Copyright © 2016 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import AVFoundation;
import UIKit;
import AudioToolbox;

public class Utilities {
    
    private func standardAlert(title: String, message: String) ->Void {
        let navMaster : NavMaster = NavMaster();
        let standardAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil);
        
        standardAlertController.addAction(confirmed);
        
        if(navMaster.presentedViewController == nil) {
            navMaster.presentViewController(standardAlertController, animated:true, completion:nil);
        }
        else if(navMaster.presentedViewController != nil) {
            navMaster.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                navMaster.presentViewController(standardAlertController, animated: true, completion: nil);
            });
        }
    }
    
    public func englishAI(textToSpeak: String) -> Void {
        let englishSpeech : AVSpeechSynthesizer = AVSpeechSynthesizer();
        let englishUtterance : AVSpeechUtterance = AVSpeechUtterance(string: textToSpeak);
        englishUtterance.rate = 0.4;
        englishUtterance.voice = AVSpeechSynthesisVoice(language: "en-US");
        englishUtterance.volume = 1.0;
        englishUtterance.pitchMultiplier = 1.0;
        
        englishSpeech.speakUtterance(englishUtterance);
    }
    
    public func batteryLevel(enabled : Bool) -> Void {
        if(enabled == true) {
        UIDevice.currentDevice().batteryMonitoringEnabled = true;
        if(UIDevice.currentDevice().batteryLevel >= 0.3 && UIDevice.currentDevice().batteryLevel < 0.5) {
            print("Battery level is running low");
            if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                englishAI("Warning low battery. Currently measured at \(UIDevice.currentDevice().batteryLevel*100)%. You should charge your iPhone as soon as possible");
            }
            else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                englishAI("Warning low battery. Currently measured at \(UIDevice.currentDevice().batteryLevel*100)%. You should charge your iPad as soon as possible");
            }
        
            standardAlert("Warning Low Battery", message: "Your battery is running low, currently measured at \(UIDevice.currentDevice().batteryLevel*100)% You should charge your battery soon");
            }
        }
        else if(enabled == false) {
            print("Battery monitoring is disabled");
        }
    }    
}