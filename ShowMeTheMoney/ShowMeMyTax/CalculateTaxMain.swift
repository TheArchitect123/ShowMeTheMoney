//
//  CalculateTaxMain.swift
//  ShowMeMyTax
//
//  Created by Dan Gerchcovich on 27/08/2016.
//  Copyright © 2016 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import CoreGraphics;
import AudioToolbox;

public class CalculateTaxMain : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var taxChoiceChoose: UITableView! = UITableView();
    //link to the app's delegate 
    var applicationDelegate : AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate;
        }
    }

    @IBOutlet var StoryboardPicker: UIPickerView? = UIPickerView();
    var button : UIButton = UIButton(type: UIButtonType.RoundedRect);
    
    
  //  var tableTaxChoice : UITableView = UITableView();
    var taxTableDict : [Int: String] = [0:"Child and dependent care credit",1:"Lifetime learning credit",2:"Saver's credit", 3:"Earned income tax credit"]; //title tax table
    var taxTableSubDict : [Int: String] = [0:"Sample Data", 1:"Sample Data", 2:"Sample Data"];  //description tax table
    let countryChoose : [Int: String] = [0: "🇺🇸 USA",1:"🇦🇺 Australia", 2:"🇬🇧 England",3:"🇨🇳 China"];
    public var incomeField : UITextField = UITextField();

    
   @objc private func CalculateTax() -> Void {
        let calculateController = UIAlertController(title: "Enter your income", message: "Enter a numbered value for your income. This could be your yearly, monthly, weekly, etc", preferredStyle: .Alert);
        
        calculateController.addTextFieldWithConfigurationHandler({(textField: UITextField) -> Void in
            textField.borderStyle = UITextBorderStyle.RoundedRect;
            textField.placeholder = "Enter your income...";
            textField.delegate = self;
            textField.keyboardType = UIKeyboardType.NumberPad;
        });
        
        let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction) ->Void in
            
            //if the user has not entered any text
            if (calculateController.textFields![0].text?.isEmpty == true) {
                self.presentViewController(calculateController, animated: true, completion: {()->Void in
                    let soundAlert : SystemSoundID = SystemSoundID(4095);
                    AudioServicesPlaySystemSound(soundAlert);
                });
            }
                //has the user entered a text
            else {
                //I have to create a guard for the iPad version. Try converting the string into a number. If the string cannot be converted into a number then callback a function to handle it
                
                //another alert controller is presented which prompts the user whether their income is yearly, monthly or hourly, etc.
                
                let timeController = UIAlertController(title: "Is this income your...", message: "", preferredStyle: UIAlertControllerStyle.Alert);
                
                let totalTaxes : CalculatedTaxController = CalculatedTaxController();
                
                
                let yearly = UIAlertAction(title: "Yearly?", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction) -> Void in
                    self.navigationController?.pushViewController(totalTaxes, animated: true);
                    self.applicationDelegate.yearlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue;
                    self.applicationDelegate.monthlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/12.0;
                    self.applicationDelegate.weeklyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/52.0;
                    self.applicationDelegate.dailyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/365.0;
                    self.applicationDelegate.hourlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/8760.0;
                    
                    
                    //AMERICAN RATES
                    
                switch(self.StoryboardPicker!.selectedRowInComponent(0)) {
                    case 0:
                    if(self.applicationDelegate.weeklyIncome <= 386) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.073;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    else if(self.applicationDelegate.weeklyIncome > 386 && self.applicationDelegate.weeklyIncome <= 771) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.094;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 771 && self.applicationDelegate.weeklyIncome <= 1154) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.101;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 1154 && self.applicationDelegate.weeklyIncome <= 1732) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.102;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                        
                    else if(self.applicationDelegate.weeklyIncome > 1732 && self.applicationDelegate.weeklyIncome <= 1828) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.093;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 1828 && self.applicationDelegate.weeklyIncome <= 1905) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.062;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }

                    else if(self.applicationDelegate.weeklyIncome > 1905) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    break;
            
                    
                    //AUSTRALIAN RATES
                    case 1:
                    if(self.applicationDelegate.weeklyIncome <= 45) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.19;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    else if(self.applicationDelegate.weeklyIncome <= 361) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2321;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    
                    else if(self.applicationDelegate.weeklyIncome <= 932) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3477;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    
                    else if(self.applicationDelegate.weeklyIncome <= 1188) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3450;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    
                        
                    else if(self.applicationDelegate.weeklyIncome <= 3111) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3900;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    
                    else if(self.applicationDelegate.weeklyIncome > 3111) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4900;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    break;
                    
                case 2: //english tax
                    if(self.applicationDelegate.weeklyIncome <= 11000) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    else if(self.applicationDelegate.weeklyIncome > 11001 && self.applicationDelegate.weeklyIncome <= 43000) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 43001 && self.applicationDelegate.weeklyIncome <= 150000) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 150000) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    break;
                case 3: //chinese tax
                    if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 375) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.03;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    else if(self.applicationDelegate.weeklyIncome > 375 && self.applicationDelegate.weeklyIncome <= 1125) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 1125 && self.applicationDelegate.weeklyIncome <= 2250) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 2250 && self.applicationDelegate.weeklyIncome <= 8750) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.25;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                        
                    else if(self.applicationDelegate.weeklyIncome > 8750 && self.applicationDelegate.weeklyIncome <= 20000) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 20000) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    break;

                    
                case 4:
                    if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 63360) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    else if(self.applicationDelegate.weeklyIncome >= 63361 && self.applicationDelegate.weeklyIncome <= 108120) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.14;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome >= 108121 && self.applicationDelegate.weeklyIncome <= 168000) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.21;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome >= 168001 && self.applicationDelegate.weeklyIncome <= 240000) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.31;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                        
                    else if(self.applicationDelegate.weeklyIncome >= 240001 && self.applicationDelegate.weeklyIncome <= 501960) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.34;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 501961 && self.applicationDelegate.weeklyIncome <= 811560) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.48;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                        
                    else if(self.applicationDelegate.weeklyIncome > 811560) {
                        self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.5;
                        self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                        
                        self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                        self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                        self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                        self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                    }
                    break;
                    

                    default:
                        print("Other selections");
                        break;
                }
                    
                    
                    //taxed amounts 
                    //pushes a navigation controller to the navigation stack and treats the text that exists in the text field as the yearly income. It does all its calculation in the next controller
                });
                
                let monthly = UIAlertAction(title: "Monthly?", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction) -> Void in
                    self.navigationController?.pushViewController(totalTaxes, animated: true);
                    
                    self.applicationDelegate.yearlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*12.0;
                    self.applicationDelegate.monthlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue;
                    self.applicationDelegate.weeklyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/4.0;
                    self.applicationDelegate.dailyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/30.0;
                    self.applicationDelegate.hourlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/672.0;
                    
                    
                    switch(self.StoryboardPicker!.selectedRowInComponent(0)) {
                    case 0:
                        if(self.applicationDelegate.weeklyIncome <= 386) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.073;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 386 && self.applicationDelegate.weeklyIncome <= 771) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.094;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 771 && self.applicationDelegate.weeklyIncome <= 1154) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.101;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1154 && self.applicationDelegate.weeklyIncome <= 1732) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.102;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome > 1732 && self.applicationDelegate.weeklyIncome <= 1828) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.093;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1828 && self.applicationDelegate.weeklyIncome <= 1905) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.062;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1905) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                        
                    //AUSTRALIAN RATES
                    case 1:
                        if(self.applicationDelegate.weeklyIncome <= 45) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.19;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome <= 361) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2321;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome <= 932) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3477;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome <= 1188) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3450;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome <= 3111) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3900;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 3111) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4900;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                    case 2: //english tax
                        if(self.applicationDelegate.weeklyIncome <= 11000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 11001 && self.applicationDelegate.weeklyIncome <= 43000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 43001 && self.applicationDelegate.weeklyIncome <= 150000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 150000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                       
                        break;
                    case 3: //chinese tax
                        if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 375) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.03;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 375 && self.applicationDelegate.weeklyIncome <= 1125) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1125 && self.applicationDelegate.weeklyIncome <= 2250) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 2250 && self.applicationDelegate.weeklyIncome <= 8750) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.25;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome > 8750 && self.applicationDelegate.weeklyIncome <= 20000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 20000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                    case 4:
                        if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 63360) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome >= 63361 && self.applicationDelegate.weeklyIncome <= 108120) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.14;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome >= 108121 && self.applicationDelegate.weeklyIncome <= 168000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.21;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome >= 168001 && self.applicationDelegate.weeklyIncome <= 240000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.31;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome >= 240001 && self.applicationDelegate.weeklyIncome <= 501960) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.34;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 501961 && self.applicationDelegate.weeklyIncome <= 811560) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.48;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 811560) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.5;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;

                    default:
                        print("Other selections");
                        break;
                    }
                    //pushes a navigation controller to the navigation stack and treats the text that exists in the text field as the yearly income. It does all its calculation in the next controller
                });
                let weekly = UIAlertAction(title: "Weekly?", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction) -> Void in
                    self.navigationController?.pushViewController(totalTaxes, animated: true);
                    
                    self.applicationDelegate.yearlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*52.0;
                    self.applicationDelegate.monthlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*4.0;
                    self.applicationDelegate.weeklyIncome = (calculateController.textFields![0].text! as NSString).doubleValue;
                    self.applicationDelegate.dailyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/7.0;
                    self.applicationDelegate.hourlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/168.0;
                    
                    switch(self.StoryboardPicker!.selectedRowInComponent(0)) {
                    case 0:
                        if(self.applicationDelegate.weeklyIncome <= 386) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.073;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 386 && self.applicationDelegate.weeklyIncome <= 771) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.094;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 771 && self.applicationDelegate.weeklyIncome <= 1154) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.101;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1154 && self.applicationDelegate.weeklyIncome <= 1732) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.102;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome > 1732 && self.applicationDelegate.weeklyIncome <= 1828) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.093;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1828 && self.applicationDelegate.weeklyIncome <= 1905) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.062;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1905) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                        
                    //AUSTRALIAN RATES
                    case 1:
                        if(self.applicationDelegate.weeklyIncome <= 45) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.19;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome <= 361) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2321;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome <= 932) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3477;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome <= 1188) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3450;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome <= 3111) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3900;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 3111) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4900;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                    case 2: //english tax
                        
                        if(self.applicationDelegate.weeklyIncome <= 11000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 11001 && self.applicationDelegate.weeklyIncome <= 43000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 43001 && self.applicationDelegate.weeklyIncome <= 150000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 150000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        
                        break;
                    case 3: //chinese tax
                        if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 375) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.03;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 375 && self.applicationDelegate.weeklyIncome <= 1125) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1125 && self.applicationDelegate.weeklyIncome <= 2250) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 2250 && self.applicationDelegate.weeklyIncome <= 8750) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.25;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome > 8750 && self.applicationDelegate.weeklyIncome <= 20000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 20000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;

                    case 4:
                        if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 63360) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome >= 63361 && self.applicationDelegate.weeklyIncome <= 108120) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.14;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome >= 108121 && self.applicationDelegate.weeklyIncome <= 168000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.21;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome >= 168001 && self.applicationDelegate.weeklyIncome <= 240000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.31;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome >= 240001 && self.applicationDelegate.weeklyIncome <= 501960) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.34;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 501961 && self.applicationDelegate.weeklyIncome <= 811560) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.48;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 811560) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.5;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                    default:
                        print("Other selections");
                        break;
                    }
                    //pushes a navigation controller to the navigation stack and treats the text that exists in the text field as the yearly income. It does all its calculation in the next controller
                });
                
                let daily = UIAlertAction(title: "Daily?", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction) -> Void in
                    self.navigationController?.pushViewController(totalTaxes, animated: true);
                    
                    
                    self.applicationDelegate.yearlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*365.0;
                    self.applicationDelegate.monthlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*30.0;
                    self.applicationDelegate.weeklyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*7.0;
                    self.applicationDelegate.dailyIncome = (calculateController.textFields![0].text! as NSString).doubleValue;
                    self.applicationDelegate.hourlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue/24.0;
                   
                    switch(self.StoryboardPicker!.selectedRowInComponent(0)) {
                    case 0:
                        if(self.applicationDelegate.weeklyIncome <= 386) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.073;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 386 && self.applicationDelegate.weeklyIncome <= 771) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.094;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 771 && self.applicationDelegate.weeklyIncome <= 1154) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.101;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1154 && self.applicationDelegate.weeklyIncome <= 1732) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.102;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome > 1732 && self.applicationDelegate.weeklyIncome <= 1828) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.093;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1828 && self.applicationDelegate.weeklyIncome <= 1905) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.062;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1905) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                        
                    //AUSTRALIAN RATES
                    case 1:
                        if(self.applicationDelegate.weeklyIncome <= 45) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.19;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome <= 361) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2321;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome <= 932) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3477;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome <= 1188) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3450;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome <= 3111) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3900;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 3111) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4900;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                    case 2: //english tax
                        if(self.applicationDelegate.weeklyIncome <= 11000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 11001 && self.applicationDelegate.weeklyIncome <= 43000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 43001 && self.applicationDelegate.weeklyIncome <= 150000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 150000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                       
                        
                        break;
                    case 3: //chinese tax
                        if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 375) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.03;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 375 && self.applicationDelegate.weeklyIncome <= 1125) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1125 && self.applicationDelegate.weeklyIncome <= 2250) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 2250 && self.applicationDelegate.weeklyIncome <= 8750) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.25;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome > 8750 && self.applicationDelegate.weeklyIncome <= 20000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 20000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;

                    case 4:
                        if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 63360) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome >= 63361 && self.applicationDelegate.weeklyIncome <= 108120) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.14;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome >= 108121 && self.applicationDelegate.weeklyIncome <= 168000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.21;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome >= 168001 && self.applicationDelegate.weeklyIncome <= 240000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.31;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome >= 240001 && self.applicationDelegate.weeklyIncome <= 501960) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.34;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 501961 && self.applicationDelegate.weeklyIncome <= 811560) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.48;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 811560) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.5;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                    default:
                        print("Other selections");
                        break;
                    }
                    //pushes a navigation controller to the navigation stack and treats the text that exists in the text field as the yearly income. It does all its calculation in the next controller
                });
                
                let hourly = UIAlertAction(title: "Hourly?", style: UIAlertActionStyle.Default, handler: {(Action: UIAlertAction) -> Void in
                    self.navigationController?.pushViewController(totalTaxes, animated: true);
                    
                    self.applicationDelegate.yearlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*8760;
                    self.applicationDelegate.monthlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*720;
                    self.applicationDelegate.weeklyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*168;
                    self.applicationDelegate.dailyIncome = (calculateController.textFields![0].text! as NSString).doubleValue*24.0;
                    self.applicationDelegate.hourlyIncome = (calculateController.textFields![0].text! as NSString).doubleValue;
                    
                    switch(self.StoryboardPicker!.selectedRowInComponent(0)) {
                    case 0:
                        if(self.applicationDelegate.weeklyIncome <= 386) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.073;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 386 && self.applicationDelegate.weeklyIncome <= 771) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.094;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 771 && self.applicationDelegate.weeklyIncome <= 1154) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.101;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1154 && self.applicationDelegate.weeklyIncome <= 1732) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.102;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome > 1732 && self.applicationDelegate.weeklyIncome <= 1828) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.093;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1828 && self.applicationDelegate.weeklyIncome <= 1905) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.062;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1905) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                        
                    //AUSTRALIAN RATES
                    case 1:
                        if(self.applicationDelegate.weeklyIncome <= 45) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.19;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome <= 361) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2321;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome <= 932) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3477;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome <= 1188) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3450;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome <= 3111) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3900;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 3111) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4900;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                    case 2: //english tax
                        
                        if(self.applicationDelegate.weeklyIncome <= 11000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 11001 && self.applicationDelegate.weeklyIncome <= 43000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.02;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 43001 && self.applicationDelegate.weeklyIncome <= 150000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.4;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 150000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                       
                        
                        break;
                    case 3:  //chinese tax
                        if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 375) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.03;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome > 375 && self.applicationDelegate.weeklyIncome <= 1125) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 1125 && self.applicationDelegate.weeklyIncome <= 2250) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.2;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 2250 && self.applicationDelegate.weeklyIncome <= 8750) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.25;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome > 8750 && self.applicationDelegate.weeklyIncome <= 20000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.3;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 20000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.45;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;

                    case 4:
                        if(self.applicationDelegate.weeklyIncome >= 0 && self.applicationDelegate.weeklyIncome <= 63360) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.1;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        else if(self.applicationDelegate.weeklyIncome >= 63361 && self.applicationDelegate.weeklyIncome <= 108120) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.14;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome >= 108121 && self.applicationDelegate.weeklyIncome <= 168000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.21;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome >= 168001 && self.applicationDelegate.weeklyIncome <= 240000) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.31;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                            
                        else if(self.applicationDelegate.weeklyIncome >= 240001 && self.applicationDelegate.weeklyIncome <= 501960) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.34;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 501961 && self.applicationDelegate.weeklyIncome <= 811560) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.48;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                            
                        else if(self.applicationDelegate.weeklyIncome > 811560) {
                            self.applicationDelegate.weeklyTaxed = self.applicationDelegate.weeklyIncome*0.5;
                            self.applicationDelegate.weeklyAfterTaxed = self.applicationDelegate.weeklyIncome-self.applicationDelegate.weeklyTaxed;
                            
                            self.applicationDelegate.yearlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*52.0;
                            self.applicationDelegate.monthlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed*4.0;
                            self.applicationDelegate.dailyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/7.0;
                            self.applicationDelegate.hourlyAfterTaxed = self.applicationDelegate.weeklyAfterTaxed/168.0;
                        }
                        break;
                        
                    default:
                        print("Other selections");
                        break;
                    }                    //pushes a navigation controller to the navigation stack and treats the text that exists in the text field as the yearly income. It does all its calculation in the next controller
                });
                
                timeController.addAction(yearly);
                timeController.addAction(monthly);
                timeController.addAction(weekly);
                timeController.addAction(daily);
                timeController.addAction(hourly);
                
                if(self.presentedViewController == nil) {
                    self.presentViewController(timeController, animated: true, completion: nil);
                }
                else {
                    self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                        self.presentViewController(timeController, animated: true, completion: nil);
                    });
                }
            }
        });
        
        let denied = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil);
        
        calculateController.addAction(confirmed);
        calculateController.addAction(denied);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(calculateController, animated: true, completion: nil);
        }
        else {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()->Void in
                self.presentViewController(calculateController, animated: true, completion: nil);
            });
        }
    }
    
    //Picker view delegate methods
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countryChoose.count;
    }
    
    public func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            return 30.0;
        }
        else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            return 60.0;
        }
            return 0;
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0) {
            switch(row) {
                case 0:
                    self.applicationDelegate.australianFilters.removeAll();
                    taxTableDict = [0:"Child tax credit",1:"Lifetime learning credit",2:"Saver's credit", 3:"Earned income tax credit"];
                    self.applicationDelegate.symbolCurrency = "$";
                    self.taxChoiceChoose.reloadData();
                    break;
                case 1:
                    self.applicationDelegate.australianFilters.removeAll();
                    taxTableDict = [0:"Superannuation",1:"Exclude tax-free threshold",2:"Student loan"];
                    self.applicationDelegate.symbolCurrency = "$";
                    self.taxChoiceChoose.reloadData();
                    break;
                case 2:
                    self.applicationDelegate.australianFilters.removeAll();
                    taxTableDict = [0:"Dividends Deduction",1:"Marriage Deduction",2:"Inheritance Deduction"];
                    self.applicationDelegate.symbolCurrency = "£";
                    self.taxChoiceChoose.reloadData();
                    break;
                case 3: //chinese
                    self.applicationDelegate.australianFilters.removeAll();
                    taxTableDict = [0:"Royalty income",1:"Rental income",2:"Labour services"];
                    self.applicationDelegate.symbolCurrency = "¥";
                    self.taxChoiceChoose.reloadData();
                    break;
                default:
                    
                    break;
            }
        }
    }

    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0) {
            switch(row) {
            case 0:
                return self.countryChoose[0];
                break;
            case 1:
                return self.countryChoose[1];
                break;
            case 2:
                return self.countryChoose[2];
                break;
            case 3:
                return self.countryChoose[3];
                break;
            case 4:
                return self.countryChoose[4];
                break;
            case 5:
                return self.countryChoose[5];
                break;
            case 6:
                return self.countryChoose[6];
                break;
            case 7:
                return self.countryChoose[7];
                break;
            case 8:
                return self.countryChoose[8];
                break;
            default:
                return self.countryChoose[9];
                break;
            }
        }
        return "";
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taxTableDict.count;
    }
    
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(self.StoryboardPicker!.selectedRowInComponent(0)) {
            case 0:   //american tax
                switch(indexPath.row) {
                    case 0:
                        if(tableView.cellForRowAtIndexPath(indexPath)!.accessoryType == UITableViewCellAccessoryType.None) {
                            tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark;
                            applicationDelegate.isChildDependency = true;
                        
                            applicationDelegate.australianFilters.append("Child tax credit");
                        
                            tableView.cellForRowAtIndexPath(indexPath)?.selected = true;
                            print("Filters count is: \(applicationDelegate.australianFilters.count)")
                        
                        }
                        else if(tableView.cellForRowAtIndexPath(indexPath)!.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                            tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.None;
                            applicationDelegate.isChildDependency = false;
                            applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Child tax credit")!);
                            tableView.cellForRowAtIndexPath(indexPath)?.selected = false;
                            print("Filters count now is: \(applicationDelegate.australianFilters.count)")
                        }
                        break;
                    case 1:
                        if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                            tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark
                            applicationDelegate.isLifetimeLearning = true;
                            applicationDelegate.australianFilters.append("Lifetime learning credit");
                            //update the cell
                        }
                        else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                            tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                            applicationDelegate.isLifetimeLearning = false;
                            applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Lifetime learning credit")!);
                        }
                        break;
                    case 2:
                        if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                            tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark;
                            applicationDelegate.australianFilters.append("Saver's credit");
                            applicationDelegate.isSaversCredit = true;
                        }
                        else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                            tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                            applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Saver's credit")!);
                            applicationDelegate.isSaversCredit = false;
                        }
                        break;
                    case 3:
                        if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                            tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark;
                            applicationDelegate.australianFilters.append("Earned income tax credit");
                            applicationDelegate.isEarnedIncome = true;
                        }
                        else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                            tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                            applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Earned income tax credit")!);
                            applicationDelegate.isEarnedIncome = false;
                        }
                        break;
                    default:
                        print("No Selection made");
                        break;
                    }
                    break;
            
            case 1: //australian tax
                switch(indexPath.row) {
                case 0:
                    if(tableView.cellForRowAtIndexPath(indexPath)!.accessoryType == UITableViewCellAccessoryType.None) {
                        tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark;
                        applicationDelegate.isSuperAnnuation = true;
                        
                        applicationDelegate.australianFilters.append("Superannuation");
                
                        print("Filters count is: \(applicationDelegate.australianFilters.count)")
                
                    }
                    else if(tableView.cellForRowAtIndexPath(indexPath)!.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                        tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.None;
                        applicationDelegate.isSuperAnnuation = false;
                        applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Superannuation")!);
                        print("Filters count now is: \(applicationDelegate.australianFilters.count)")
                    }
                    break;
                case 1:
                    if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                        tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark
                        applicationDelegate.isTaxFreeThreshold = false;
                        applicationDelegate.australianFilters.append("Exclude tax-free threshold");
                    //update the cell
                    }
                    else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                        tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                        applicationDelegate.isTaxFreeThreshold = true;
                        applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Exclude tax-free threshold")!);
                    }
                break;
                case 2:
                    if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                        tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark;
                        applicationDelegate.australianFilters.append("Student loan");
                        applicationDelegate.isStudentLoan = true;
                    }
                    else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                        tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                        applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Student loan")!);
                        applicationDelegate.isStudentLoan = false;
                    }
                    break;
                default:
                    print("No Selection made");
                    break;
                }
                break;
        case 2: //english tax
            switch(indexPath.row) {
            case 0:
                if(tableView.cellForRowAtIndexPath(indexPath)!.accessoryType == UITableViewCellAccessoryType.None) {
                    tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark;
                    //applicationDelegate = true;
                    
                    self.applicationDelegate.australianFilters.append("Dividends Deduction");
            
                    self.applicationDelegate.isDividends = true;
                    print("Filters count is: \(applicationDelegate.australianFilters.count)")
                    
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)!.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                    tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.None;
                    applicationDelegate.isDividends = false;
                    self.applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Dividends Deduction")!);
                    print("Filters count now is: \(applicationDelegate.australianFilters.count)")
                }
                break;
            case 1:
                
                if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                    tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark
                    applicationDelegate.isMarriage = true;
                    self.applicationDelegate.australianFilters.append("Marriage Deduction");
                    //update the cell
                }
                else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                    tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                    applicationDelegate.isMarriage = false;
                    self.applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Marriage Deduction")!);
                }
                break;
            case 2:
                
                if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                    tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark;
                    self.applicationDelegate.australianFilters.append("Inheritance Deduction");
                    applicationDelegate.isInheritance = true;
                }
                else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                    tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                    self.applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Inheritance Deduction")!);
                    applicationDelegate.isInheritance = false;
                }
            default:
                print("No Selection made");
                break;
            }
            break;
            
        case 3: //chinese tax
            switch(indexPath.row) {
            case 0:
                if(tableView.cellForRowAtIndexPath(indexPath)!.accessoryType == UITableViewCellAccessoryType.None) {
                    tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.Checkmark;
                    applicationDelegate.isRoyaltyIncome = true;
                    
                    self.applicationDelegate.australianFilters.append("Royalty income");
                    
                    print("Filters count is: \(applicationDelegate.australianFilters.count)")
                    
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)!.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                    tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = UITableViewCellAccessoryType.None;
                    applicationDelegate.isRoyaltyIncome = false;
                   self.applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Royalty income")!);
                    print("Filters count now is: \(applicationDelegate.australianFilters.count)")
                }
                break;
            case 1:
                
                if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                    tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark
                    applicationDelegate.isRentalIncome = true;
                    self.applicationDelegate.australianFilters.append("Rental income");
                    //update the cell
                }
                else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                    tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                    applicationDelegate.isRentalIncome = false;
                    self.applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Rental income")!);
                }
                break;
            case 2:
                
                if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.None) {
                    tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.Checkmark;
                    self.applicationDelegate.australianFilters.append("Labour services");
                    applicationDelegate.isLabourServices = true;
                }
                else if(tableView.cellForRowAtIndexPath((indexPath))?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                    tableView.cellForRowAtIndexPath((indexPath))?.accessoryType = UITableViewCellAccessoryType.None;
                    self.applicationDelegate.australianFilters.removeAtIndex(applicationDelegate.australianFilters.indexOf("Labour services")!);
                    applicationDelegate.isLabourServices = false;
                }
                
                
            default:
                print("No Selection made");
                break;
            }
            break;
                default:
                    break;
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                return "              📚 Tax Deductibles";
            }
            else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
                return "              📚 Tax Deductibles";
            }
        return "";
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let filters = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell");
        
        filters.textLabel?.text = taxTableDict[indexPath.row];
        filters.textLabel?.textColor = UIColor.blackColor();
        
        filters.textLabel?.adjustsFontSizeToFitWidth = true;
        
        tableView.contentInset = UIEdgeInsetsMake(1.0, 0.3, 3.0, 0);
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight) {
                filters.textLabel?.adjustsFontSizeToFitWidth = true;
            } else if(UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait || UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown) {
                filters.textLabel?.adjustsFontSizeToFitWidth = true;
            }
            
        }
        
       else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight) {
                filters.textLabel?.adjustsFontSizeToFitWidth = true;
            } else if(UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait || UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown) {
                filters.textLabel?.adjustsFontSizeToFitWidth = true;
            }
        }
    
        return filters;
    }
    
    //adjsut the orientation and the frae of th etable accroding to the of device and the orientartion of the device
    public func textFieldDidEndEditing(textField: UITextField) {
        self.incomeField.resignFirstResponder();
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.incomeField.resignFirstResponder();
        return true;
    }
    
    public override func viewDidAppear(animated: Bool) {
        let tabMaster = TabMaster();
        tabMaster.barButton.customView = button;
        self.navigationItem.setRightBarButtonItem(tabMaster.barButton, animated: true);
    }
    
    public override func viewWillLayoutSubviews() {
        let screenWidth = UIScreen.mainScreen().bounds.width;
        let screenHeight = UIScreen.mainScreen().bounds.height / 3.0;
        
        //Runtime on iPhone
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft) {
                self.StoryboardPicker?.center = CGPoint(x: self.view.center.x, y: 50);
                
                self.StoryboardPicker!.bounds = CGRect(x:0 , y: 0, width: screenWidth-40, height: screenHeight + 35);
                
                self.taxChoiceChoose.frame = CGRect(x: 15, y: 135, width: screenWidth - 30, height: screenHeight + 60.0);
            
                
                }
                else if(UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait || UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown){
                    self.StoryboardPicker?.center = CGPoint(x: self.view.center.x, y: 110);
                
                    self.StoryboardPicker!.bounds = CGRect(x:0 , y: 0, width: screenWidth-30, height: screenHeight + 20);
                
                    self.taxChoiceChoose.frame = CGRect(x: 5, y: 218, width: screenWidth - 10, height: screenHeight + 60.0);
                }
            }
            
            
            //Runtime on IPAD
            else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            
            //landscape device orientation
            if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft) {
                
                self.StoryboardPicker!.center = CGPoint(x: self.view.center.x,y: 180);
                self.StoryboardPicker!.bounds = CGRect(x: 0, y: 0, width: screenWidth - 125, height: screenHeight);
                
                self.taxChoiceChoose.frame = CGRect(x: 35, y: 360, width: screenWidth - 70, height: screenHeight + 200.0);
            }
                //portrait device orientation
            else if(UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait || UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown) {
                
                self.StoryboardPicker!.center = CGPoint(x: self.view.center.x,y: 180);
                self.StoryboardPicker!.bounds = CGRect(x: 0, y: 0, width: screenWidth - 80, height: screenHeight/1.2);
                
                self.taxChoiceChoose.frame = CGRect(x: 25, y: 370, width: screenWidth - 50, height: screenHeight + 305.0);

            }
        }
    }
    
    public override func viewDidLoad() {
        let screenWidth = UIScreen.mainScreen().bounds.width;
        let screenHeight = UIScreen.mainScreen().bounds.height / 3.0;
        
        //when app loads it can only start with portrait mode. But then it can be both portrait and landscape orientations
        
        //iPhone
        //initial frame when the view first loads into memory
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft) {
                self.StoryboardPicker?.center = CGPoint(x: self.view.center.x, y: 50);
                
                self.StoryboardPicker!.bounds = CGRect(x:0 , y: 0, width: screenWidth-40, height: screenHeight + 35);
                
                self.taxChoiceChoose.frame = CGRect(x: 15, y: 135, width: screenWidth - 30, height: screenHeight + 60.0);
                
                
            }
            else if(UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait || UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown){
                self.StoryboardPicker?.center = CGPoint(x: self.view.center.x, y: 110);
                
                self.StoryboardPicker!.bounds = CGRect(x:0 , y: 0, width: screenWidth-30, height: screenHeight + 20);
                
                self.taxChoiceChoose.frame = CGRect(x: 5, y: 218, width: screenWidth - 10, height: screenHeight + 60.0);
            }
        } else if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            //landscape device orientation
            if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft) {
                
                self.StoryboardPicker!.center = CGPoint(x: self.view.center.x,y: 180);
                self.StoryboardPicker!.bounds = CGRect(x: 0, y: 0, width: screenWidth - 125, height: screenHeight);
                
                self.taxChoiceChoose.frame = CGRect(x: 35, y: 380, width: screenWidth - 70, height: screenHeight + 200.0);
                
            }
                //portrait device orientation
            else if(UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait || UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown){
                
                self.StoryboardPicker!.center = CGPoint(x: self.view.center.x,y: 180);
                self.StoryboardPicker!.bounds = CGRect(x: 0, y: 0, width: screenWidth - 80, height: screenHeight/1.2);
                
                
                self.taxChoiceChoose.frame = CGRect(x: 25, y: 370, width: screenWidth - 50, height: screenHeight + 305.0);
            }
        }
        
        self.button.frame = CGRect(x:40,y: 20,width: 65, height: 40);
        self.button.setTitle("Calculate", forState: UIControlState.Highlighted);
        self.button.setTitle("Calculate", forState: UIControlState.Normal);
        
        self.button.showsTouchWhenHighlighted = true;
        
        self.button.addTarget(self, action: #selector(self.CalculateTax), forControlEvents: .TouchDown);
        
        print("Is button pressed: \(button.touchInside)");
        
        if(self.button.touchInside == true) {
            self.CalculateTax();
        }
        
        self.StoryboardPicker!.showsSelectionIndicator = true;
        
        self.StoryboardPicker!.delegate = self;
        self.StoryboardPicker!.dataSource = self;
        
        self.view.backgroundColor = UIColor.whiteColor();

        self.incomeField.placeholder = "Your income...";
        self.incomeField.borderStyle = UITextBorderStyle.RoundedRect;
        self.incomeField.delegate = self;
        
        self.taxChoiceChoose.delegate = self;
        self.taxChoiceChoose.dataSource = self;
        
        self.taxChoiceChoose.alwaysBounceHorizontal = false;
        self.taxChoiceChoose.showsHorizontalScrollIndicator = false;
        
        //superview's background color
        self.view.backgroundColor = UIColor.lightGrayColor();
        
        //front end color properties
        self.StoryboardPicker!.tintColor = UIColor.whiteColor();
        self.StoryboardPicker!.backgroundColor = UIColor.whiteColor();
        self.StoryboardPicker!.layer.borderWidth = 0.4;
        
        //this should create a black border background around the table view, but let's see
        self.taxChoiceChoose.separatorColor = UIColor.blackColor();
        self.taxChoiceChoose.tintColor = UIColor.blackColor();
        self.taxChoiceChoose.backgroundColor = UIColor.whiteColor();
        self.taxChoiceChoose.layer.borderWidth = 0.4;
        self.taxChoiceChoose.rowHeight = 70.0;
        
        self.view.addSubview(self.StoryboardPicker!);
        self.view.addSubview(self.taxChoiceChoose);
    }
    
    public override func didReceiveMemoryWarning() {
        //dispose of any resources if a memory leak occurs
    }
}