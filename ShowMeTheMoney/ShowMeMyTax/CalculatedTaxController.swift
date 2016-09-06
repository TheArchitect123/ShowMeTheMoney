//
//  CalculatedTaxController.swift
//  ShowMeMyTax
//
//  Created by Dan Gerchcovich on 27/08/2016.
//  Copyright © 2016 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;
import AVFoundation;

public class CalculatedTaxController : UITableViewController {
    
    //in this controller the info is split up into 4 different sections similar ot he pay calc 
    //I gotta think about a good front end for this. 
    
    var taxedIncomeDict : [String] = ["Yearly", "Monthly", "Weekly", "Daily", "Hourly"];
    var grossIncomeDict : [String] = ["Yearly", "Monthly", "Weekly", "Daily", "Hourly"];
    
    private var infoButton : UIButton = UIButton(type: UIButtonType.InfoLight);
    
    private var taxOptionsTitle : String = "";
    private var taxOptionsMessage : String = "";
    
    var filters: [String] = [];
    
    //taxed payment
    var yearlyTaxed : Double = 0;
    var monthlyTaxed : Double = 0;
    var weeklyTaxed : Double = 0;
    var dailyTaxed : Double = 0;
    var hourlyTaxed : Double = 0;
    
    //gross payment
    var yearlyGross : Double = 0;
    var monthlyGross : Double = 0;
    var weeklyGross : Double = 0;
    var dailyGross : Double = 0;
    var hourlyGross : Double = 0;
    
    var currencySymbol : String = "";
    
    
    //used to pass memory from the main calc controller to this controller
    var memoryDelegate : AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate;
        }
    }
    
    
    private func extraDetail(title: String, message: String) {
        let infoController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
    
        let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        infoController.addAction(confirmed);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(infoController, animated: true, completion: nil);
        }
        else {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()-> Void in
            self.presentViewController(infoController, animated: true, completion: nil);
        });
    }
}

    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.section) {
            case 0:
                switch(indexPath.row) {
                case 0: //yearly
                    extraDetail("Yearly income after tax", message: "Your yearly income after tax is measured at \(self.currencySymbol)\(self.yearlyTaxed)");
                    break;
                case 1: //monthly
                    extraDetail("Monthly income after tax", message: "Your monthly income after tax is measured at \(self.currencySymbol)\(self.monthlyTaxed)");
                    break;
                case 2: //weekly
                    extraDetail("Weekly income after tax", message: "Your weekly income after tax is measured at \(self.currencySymbol)\(self.weeklyTaxed)");
                    break;
                case 3: //daily
                    extraDetail("Daily income after tax", message: "Your daily income after tax is measured at \(self.currencySymbol)\(self.dailyTaxed)");
                    break;
                case 4: //hourly
                    extraDetail("Hourly income after tax", message: "Your hourly income after tax is measured at \(self.currencySymbol)\(self.hourlyTaxed)");
                    break;
                default:
                    break;
                }

                break;
            case 1:
                switch(indexPath.row) {
                case 0: //yearly
                    extraDetail("Yearly Income", message: "Your yearly gross income is measured at \(self.currencySymbol)\(self.yearlyGross)");
                    break;
                case 1: //monthly
                    extraDetail("Monthly Income", message: "Your monthly gross income is measured at \(self.currencySymbol)\(self.monthlyGross)");
                    break;
                case 2: //weekly
                    extraDetail("Weekly Income", message: "Your weekly gross income is measured at \(self.currencySymbol)\(self.weeklyGross)");
                    break;
                case 3: //daily
                    extraDetail("Daily Income", message: "Your daily gross income is measured at \(self.currencySymbol)\(self.dailyGross)");
                    break;
                case 4: //hourly
                    extraDetail("Hourly Income", message: "Your hourly gross income is measured at \(self.currencySymbol)\(self.hourlyGross)");
                    break;
                default:
                    break;
                }
                break;
            default:
                
                break;
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3;
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
            case 0:
                return taxedIncomeDict.count;
                break;
            case 1:
                return grossIncomeDict.count;
                break;
            default:
                return memoryDelegate.australianFilters.count;
                break;
        }
        return 0;
    }
    
    public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
            case 0:
                return "📖 Income After Taxes";
                break;
            
            case 1:
                return "💰 Gross Income";
                break;
            default:
                return "🔮 Tax Options Chosen";
                break;
        }
        return "";
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell");
       
        tableCell.textLabel?.adjustsFontSizeToFitWidth = true;
        
        var labelText : UILabel = UILabel(frame: CGRect(x: 0, y: 20, width: 75, height: 40));
        tableCell.accessoryView = labelText;
        self.currencySymbol = memoryDelegate.symbolCurrency;
        
        self.yearlyGross = Double(round(self.memoryDelegate.yearlyIncome*100))/100;
        self.monthlyGross = Double(round(self.memoryDelegate.monthlyIncome*100))/100;
        self.weeklyGross = Double(round(self.memoryDelegate.weeklyIncome*100))/100;
        self.dailyGross = Double(round(self.memoryDelegate.dailyIncome*100))/100;
        self.hourlyGross = Double(round(self.memoryDelegate.hourlyIncome*100))/100;
        
        var mainPage = CalculateTaxMain();
        
        //AMERICAN TAXED INCOME 
        
        
   switch(mainPage.StoryboardPicker!.selectedRowInComponent(0)) {
        case 0: //AMERICAN TAXED INCOME
            //default state if user does not choose any of the deductables
            if(self.memoryDelegate.isChildDependency == false && self.memoryDelegate.isLifetimeLearning == false && self.memoryDelegate.isSaversCredit == false && self.memoryDelegate.isEarnedIncome == false) {
                //default tax income
                self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed*100))/100;
                self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed*100))/100;
                self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed*100))/100;
                self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed*100))/100;
                self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed*100))/100;
            }
            
            
            //I cannot use unary + operator to add to the total tax values inside the application's delegate
            if(self.memoryDelegate.isChildDependency == true) {            
                self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed+1000)*100.0)/100.0;
                self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed+83.33)*100)/100;
                self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed+19.23)*100)/100;
                self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed+19.23)*100)/100;
                self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed+0.114)*100)/100;
                
            }
            else if(self.memoryDelegate.isLifetimeLearning == true) {
                 if(self.yearlyGross > 65000 && self.yearlyGross <= 130000) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed+2000)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed+166.67)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed+38.46)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed+5.479)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed+0.228)*100)/100;
                }
            }
            else if(self.memoryDelegate.isSaversCredit == true) {
                self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed+1000)*100)/100;
                self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed+83.33)*100)/100;
                self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed+19.23)*100)/100;
                self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed+19.23)*100)/100;
                self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed+0.114)*100)/100;
            }
            
                
                //assumes one dependent
            else if(self.memoryDelegate.isEarnedIncome == true) {
                self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed+3359)*100)/100;
                self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed+279.916)*100)/100;
                self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed+64.596)*100)/100;
                self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed+9.203)*100)/100;
                self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed+0.3834)*100)/100;
            }
            break;
        
        case 1:
        //AUSTRALIAN TAXED INCOME
        if(self.memoryDelegate.isStudentLoan == false && self.memoryDelegate.isSuperAnnuation == false && self.memoryDelegate.isTaxFreeThreshold == false) {
            //default tax income
            self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed*100))/100;
            self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed*100))/100;
            self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed*100))/100;
            self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed*100))/100;
            self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed*100))/100;
        }
        
        if(self.memoryDelegate.isSuperAnnuation == true) {
            self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.095)*100)/100;
            self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.095)*100)/100;
            self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.095)*100)/100;
            self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.095)*100)/100;
            self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.095)*100)/100;
            
        }
        else if(self.memoryDelegate.isTaxFreeThreshold == true) {
            self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed+18200)*100)/100;
            self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed+1400)*100)/100;
            self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed+350)*100)/100;
            self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed+50.0)*100)/100;
            self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed+2.0833)*100)/100;
        }
        else if(self.memoryDelegate.isStudentLoan == true) {
            if(self.yearlyGross >= 54869) {
                if(self.yearlyGross >= 54869 && self.yearlyGross <= 61119) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.04)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.04)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.04)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.04)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.04)*100)/100;
                }
                else if(self.yearlyGross >= 61120 && self.yearlyGross <= 67368) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.045)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.045)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.045)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.045)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.045)*100)/100;
                }
                else if(self.yearlyGross >= 67369 && self.yearlyGross <= 70909) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.05)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.05)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.05)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.05)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.05)*100)/100;
                }
                
                else if(self.yearlyGross >= 70910 && self.yearlyGross <= 76222) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.055)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.055)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.055)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.055)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.055)*100)/100;
                }
                else if(self.yearlyGross >= 76223 && self.yearlyGross <= 82550) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.06)*100)/100;
                    self.monthlyTaxed = Double(round( self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.06)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.06)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.06)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.06)*100)/100;
                }
                
                else if(self.yearlyGross >= 82551 && self.yearlyGross <= 86894) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.065)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.065)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.065)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.065)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.065)*100)/100;
                }
                    
                    
                else if(self.yearlyGross >= 86895 && self.yearlyGross <= 95626) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.07)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.07)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.07)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.07)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.07)*100)/100;
                }
                
                else if(self.yearlyGross >= 95627 && self.yearlyGross <= 101899) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.075)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.075)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.075)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.075)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.075)*100)/100;
                }
                
                else if(self.yearlyGross >= 101900) {
                    self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed-self.memoryDelegate.yearlyAfterTaxed*0.08)*100)/100;
                    self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed-self.memoryDelegate.monthlyAfterTaxed*0.08)*100)/100;
                    self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed-self.memoryDelegate.weeklyAfterTaxed*0.08)*100)/100;
                    self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed-self.memoryDelegate.dailyAfterTaxed*0.08)*100)/100;
                    self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed-self.memoryDelegate.hourlyAfterTaxed*0.08)*100)/100;
                }
            }
        }
            break;
    
        case 2:
    //default state if user does not choose any of the deductables
    if(self.memoryDelegate.isInheritance == false && self.memoryDelegate.isMarriage == false && self.memoryDelegate.isDividends == false) {
        //default tax income
        self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed*100))/100;
        self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed*100))/100;
        self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed*100))/100;
        self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed*100))/100;
        self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed*100))/100;
    }
    
    
    //I cannot use unary + operator to add to the total tax values inside the application's delegate
    if(self.memoryDelegate.isInheritance == true) {
        //assumes inheritance > 325000
        self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed*0.4)*100)/100;
        self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed*0.4)*100)/100;
        self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed*0.4)*100)/100;
        self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed*0.4)*100)/100;
        self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed*0.4)*100)/100;
    }
    else if(self.memoryDelegate.isMarriage == true) {
        self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed+220)*100)/100;
        self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed+18.33)*100)/100;
        self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed+4.23)*100)/100;
        self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed+0.6027)*100)/100;
        self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed+0.02511)*100)/100;
    }
        
    else if(self.memoryDelegate.isDividends == true) {
        self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed)*100)/100;
        self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed)*100)/100;
        self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed)*100)/100;
        self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed)*100)/100;
        self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed)*100)/100;
    }
    break;
    
        case 3: //CHINESE TAXED INCOME
            //default state if user does not choose any of the deductables
            if(self.memoryDelegate.isRoyaltyIncome == false && self.memoryDelegate.isSmallBusinessExpenses == false && self.memoryDelegate.isRentalIncome == false && self.memoryDelegate.isLabourServices == true) {
                    //default tax income
                self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed*100))/100;
                self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed*100))/100;
                self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed*100))/100;
                self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed*100))/100;
                self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed*100))/100;
            }
    
    
                //I cannot use unary + operator to add to the total tax values inside the application's delegate
            if(self.memoryDelegate.isRoyaltyIncome == true) {
                self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed+800)*100)/100;
                self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed+66.67)*100)/100;
                self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed+15.3846)*100)/100;
                self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed+2.1917)*100)/100;
                self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed+0.0913)*100)/100;
            }
            else if(self.memoryDelegate.isRentalIncome == true) {
                self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed+800)*100)/100;
                self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed+66.67)*100)/100;
                self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed+15.3846)*100)/100;
                self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed+2.1917)*100)/100;
                self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed+0.0913)*100)/100;
            }
    
            else if(self.memoryDelegate.isLabourServices == true) {
                self.yearlyTaxed = Double(round(self.memoryDelegate.yearlyAfterTaxed+800)*100)/100;
                self.monthlyTaxed = Double(round(self.memoryDelegate.monthlyAfterTaxed+66.67)*100)/100;
                self.weeklyTaxed = Double(round(self.memoryDelegate.weeklyAfterTaxed+15.3846)*100)/100;
                self.dailyTaxed = Double(round(self.memoryDelegate.dailyAfterTaxed+2.1917)*100)/100;
                self.hourlyTaxed = Double(round(self.memoryDelegate.hourlyAfterTaxed+0.0913)*100)/100;
            }
            
            break;
        default:
            break;
    }

        switch(indexPath.section) {
            case 0:
                tableCell.textLabel?.text = taxedIncomeDict[indexPath.row];
                tableCell.textLabel?.textColor = UIColor.blackColor();
                
                tableCell.detailTextLabel?.text = "";
                tableCell.detailTextLabel?.textColor = UIColor.lightGrayColor();
                
                switch(indexPath.row) {
                    case 0: //yearly
                        labelText.text = "\(self.currencySymbol)\(yearlyTaxed)";
                        
                        self.view.addSubview(labelText);
                        break;
                    case 1: //monthly
                        labelText.text = "\(self.currencySymbol)\(monthlyTaxed)";
                        break;
                    case 2: //weekly
                        labelText.text = "\(self.currencySymbol)\(weeklyTaxed)";
                        break;
                    case 3: //daily
                        labelText.text = "\(self.currencySymbol)\(dailyTaxed)";
                        break;
                    case 4: //hourly
                        labelText.text = "\(self.currencySymbol)\(hourlyTaxed)";
                        break;
                    default:
                        break;
                    }
                return tableCell;
                break;
            case 1:
                tableCell.textLabel?.text = grossIncomeDict[indexPath.row];
                tableCell.textLabel?.textColor = UIColor.blackColor();
                
                tableCell.detailTextLabel?.text = "";
                tableCell.detailTextLabel?.textColor = UIColor.lightGrayColor();
                
                switch(indexPath.row) {
                case 0: //yearly
                    print("Symbol currency \(self.currencySymbol)");
                    labelText.text = "\(self.currencySymbol)\(yearlyGross)";
                    break;
                case 1: //monthly
                    labelText.text = "\(self.currencySymbol)\(monthlyGross)";
                    break;
                case 2: //weekly
                    labelText.text = "\(self.currencySymbol)\(weeklyGross)";
                    break;
                case 3: //daily
                    labelText.text = "\(self.currencySymbol)\(dailyGross)";
                    break;
                case 4: //hourly
                    labelText.text = "\(self.currencySymbol)\(hourlyGross)";
                    break;
                default:
                    break;
                }
                return tableCell;
                    break;
                default:
                    //filters that the user has selected
                    tableCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell");
                    tableCell.textLabel?.text = memoryDelegate.australianFilters[indexPath.row];
                    tableCell.textLabel?.textColor = UIColor.blackColor();
            
                    tableCell.accessoryType = UITableViewCellAccessoryType.DetailButton;
                
    
                    return tableCell;
                    break;
            }
            return tableCell;
        }
    

    public override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section) {
        case 2:
            switch(indexPath.row) {
            case 0:
                
                 //american tax filters
                 if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Child tax credit") {
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help people with dependents, where each dependent is $1000. Note this calculator assumes you have one dependent.");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Lifetime learning credit"){
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This option is designed to help students with their tuition fees, at $2000 per year.");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Saver's credit"){
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is designed to help low to moderate income earners to save money on their tax payments. You save $1000 a year with this tax deductible option.");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Earned income tax credit"){
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This option is designed to help low to moderate income earners to save money on their tax payments, if they have dependents. Note this calculator assumes you have one dependent where you will save $3359");
                 }
                 
                 
                 //Australian tax filters
                 if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Superannuation") {
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "In this current year 9.5% is the superannuation rate. This is the portion of your super that your employer takes from your income, and adds it to your super account");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Exclude tax-free threshold"){
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "In this current year $18200 is the tax free threshold. This means that you pay less tax until you earn more than $18,200. If however you make $18,200 or less than you can reclaim it on your tax refund");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Student loan"){
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is the contribution that you will start to repay only when you make more than $54,869 at a rate of 4.0%. The more money you make the higher the rate will be, where the maximum rate is 8.0%");
                 }
                 
                 //ENGLISH TAX FILTERS
                 if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Dividends Deduction") { //royalty income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help you if you have passive income from shares. This calculator assumes that your dividends are less than £5000");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Marriage Deduction"){ //rental income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help people who are married. Here you can transfer a maximum of £1100 to your spouse which reduces your tax by £220");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Inheritance Deduction"){ //labour income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is designed to assist people who have inherited money from a loved one who has died. Note this calculator assumes that your inheritance exceeds £325,000.");
                 }
                 
                 
                 
                 //chinese tax filters
                 if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Royalty income") { //royalty income
                 print("Select option 0");
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help who have passive income. This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000.");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Rental income"){ //rental income
                 print("Select option 0");
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help who have passive income (Realestate). This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000");
                 }
                 else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Labour services"){ //labour income
                 print("Select option 0");
                 extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "Labour services includes things security, maintance, etc. This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000");
                 }
                break;
                
            case 1:
                //american tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Child tax credit") {
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help people with dependents, where each dependent is $1000. Note this calculator assumes you have one dependent.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Lifetime learning credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This option is designed to help students with their tuition fees, at $2000 per year.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Saver's credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is designed to help low to moderate income earners to save money on their tax payments. You save $1000 a year with this tax deductible option.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Earned income tax credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This option is designed to help low to moderate income earners to save money on their tax payments, if they have dependents. Note this calculator assumes you have one dependent where you will save $3359");
                }
                
                
                //Australian tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Superannuation") {
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "In this current year 9.5% is the superannuation rate. This is the portion of your super that your employer takes from your income, and adds it to your super account");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Exclude tax-free threshold"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "In this current year $18200 is the tax free threshold. This means that you pay less tax until you earn more than $18,200. If however you make $18,200 or less than you can reclaim it on your tax refund");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Student loan"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is the contribution that you will start to repay only when you make more than $54,869 at a rate of 4.0%. The more money you make the higher the rate will be, where the maximum rate is 8.0%");
                }
                
                //ENGLISH TAX FILTERS
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Dividends Deduction") { //royalty income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help you if you have passive income from shares. This calculator assumes that your dividends are less than £5000");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Marriage Deduction"){ //rental income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help people who are married. Here you can transfer a maximum of £1100 to your spouse which reduces your tax by £220");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Inheritance Deduction"){ //labour income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is designed to assist people who have inherited money from a loved one who has died. Note this calculator assumes that your inheritance exceeds £325,000.");
                }
                
                //chinese tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Royalty income") { //royalty income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help who have passive income. This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Rental income"){ //rental income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help who have passive income (Realestate). This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Labour services"){ //labour income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "Labour services includes things security, maintance, etc. This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000");
                }
                break;
                
            case 2:
                //american tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Child tax credit") {
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help people with dependents, where each dependent is $1000. Note this calculator assumes you have one dependent.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Lifetime learning credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This option is designed to help students with their tuition fees, at $2000 per year.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Saver's credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is designed to help low to moderate income earners to save money on their tax payments. You save $1000 a year with this tax deductible option.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Earned income tax credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This option is designed to help low to moderate income earners to save money on their tax payments, if they have dependents. Note this calculator assumes you have one dependent where you will save $3359");
                }
                
                
                //Australian tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Superannuation") {
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "In this current year 9.5% is the superannuation rate. This is the portion of your super that your employer takes from your income, and adds it to your super account");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Exclude tax-free threshold"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "In this current year $18200 is the tax free threshold. This means that you pay less tax until you earn more than $18,200. If however you make $18,200 or less than you can reclaim it on your tax refund");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Student loan"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is the contribution that you will start to repay only when you make more than $54,869 at a rate of 4.0%. The more money you make the higher the rate will be, where the maximum rate is 8.0%");
                }
                
                //ENGLISH TAX FILTERS 
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Dividends Deduction") { //royalty income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help you if you have passive income from shares. This calculator assumes that your dividends are less than £5000");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Marriage Deduction"){ //rental income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help people who are married. Here you can transfer a maximum of £1100 to your spouse which reduces your tax by £220");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Inheritance Deduction"){ //labour income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is designed to assist people who have inherited money from a loved one who has died. Note this calculator assumes that your inheritance exceeds £325,000.");
                }
                
                //chinese tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Royalty income") { //royalty income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help who have passive income. This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Rental income"){ //rental income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help who have passive income (Realestate). This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Labour services"){ //labour income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "Labour services includes things security, maintance, etc. This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000");
                }
                break;
                
            
            default:
                //american tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Child tax credit") {
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help people with dependents, where each dependent is $1000. Note this calculator assumes you have one dependent.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Lifetime learning credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This option is designed to help students with their tuition fees, at $2000 per year.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Saver's credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is designed to help low to moderate income earners to save money on their tax payments. You save $1000 a year with this tax deductible option.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Earned income tax credit"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This option is designed to help low to moderate income earners to save money on their tax payments, if they have dependents. Note this calculator assumes you have one dependent where you will save $3359");
                }
                
                
                //Australian tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Superannuation") {
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "In this current year 9.5% is the superannuation rate. This is the portion of your super that your employer takes from your income, and adds it to your super account");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Exclude tax-free threshold"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "In this current year $18200 is the tax free threshold. This means that you pay less tax until you earn more than $18,200. If however you make $18,200 or less than you can reclaim it on your tax refund");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Student loan"){
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is the contribution that you will start to repay only when you make more than $54,869 at a rate of 4.0%. The more money you make the higher the rate will be, where the maximum rate is 8.0%");
                }
                
                //ENGLISH TAX FILTERS
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Dividends Deduction") { //royalty income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help you if you have passive income from shares. This calculator assumes that your dividends are less than £5000");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Marriage Deduction"){ //rental income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help people who are married. Here you can transfer a maximum of £1100 to your spouse which reduces your tax by £220");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Inheritance Deduction"){ //labour income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This is designed to assist people who have inherited money from a loved one who has died. Note this calculator assumes that your inheritance exceeds £325,000.");
                }
                
                
                //chinese tax filters
                if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Royalty income") { //royalty income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help who have passive income. This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000.");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Rental income"){ //rental income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "This tax deductible option is designed to help who have passive income (Realestate). This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000");
                }
                else if(tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "Labour services"){ //labour income
                    print("Select option 0");
                    extraDetail((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!, message: "Labour services includes things security, maintance, etc. This calculator assumes that your passive income for the recorded tax year does not exceed ¥4000");
                }
                break;
                
            }
            break;
        default:
            break;
        }
    }
    
    public func buttonInfo() {
        
        let infoController = UIAlertController(title: self.taxOptionsTitle, message: self.taxOptionsMessage, preferredStyle: UIAlertControllerStyle.Alert);
            
        
        let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        infoController.addAction(confirmed);
        if(self.presentedViewController == nil) {
            self.presentViewController(infoController, animated: true, completion: nil);
        }
        else {
            self.presentedViewController?.dismissViewControllerAnimated(true, completion: {()-> Void in
                self.presentViewController(infoController, animated: true, completion: nil);
                });
        }
    }
    
    @objc private func instructions() {
        let taxCalc : CalculateTaxMain = CalculateTaxMain();
    
        let instructionsControllerAmerican = UIAlertController(title: "Your PAYG tax", message: "This page describes your employee, PAYG (Pay As You Go) tax. Note this calculator assumes you work 24/7 days a week, since that I cannot know how many hours you work a day", preferredStyle: .Alert);
        
        let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        instructionsControllerAmerican.addAction(confirmed);
        
        if(self.presentedViewController == nil) {
            self.presentViewController(instructionsControllerAmerican, animated: true, completion: nil);
        }
        else {
            self.presentViewController(instructionsControllerAmerican, animated: true, completion: nil);
        }
}

    public override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if(event!.type == UIEventType.Motion) {
            let instructionsController = UIAlertController(title: "Start Again?", message: "Would you like to start over?", preferredStyle: .Alert);
            
            let confirmed = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(Action : UIAlertAction)->Void in
                self.navigationController?.popViewControllerAnimated(true);
            });
            
            instructionsController.addAction(confirmed);
            
            if(self.presentedViewController == nil) {
                self.presentViewController(instructionsController, animated: true, completion: nil);
            }
                
            else {
                self.presentViewController(instructionsController, animated: true, completion: nil);
            }
        }
    }
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait;
    }
    
    public override func shouldAutorotate() -> Bool {
        return false;
    }
    
    public override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait;
    }
    
    public func restartControl() {
        self.navigationController?.popViewControllerAnimated(true);
    }
    public override func viewDidLoad() {
        print("Filters count is: \(memoryDelegate.australianFilters.count)")
        
        let restart : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: #selector(self.restartControl));
        
        self.navigationItem.setLeftBarButtonItem(restart, animated: false);
        
        self.view.backgroundColor = UIColor.whiteColor();
        
        let infoButton = UIButton(type: UIButtonType.InfoLight);
        
        infoButton.frame = CGRect(x: 0, y: 20, width: 40, height: 40);
        
        infoButton.addTarget(self, action: #selector(self.instructions), forControlEvents: UIControlEvents.TouchDown);
        
        let infoBar = UIBarButtonItem();
        infoBar.customView = infoButton;
        
        self.tableView.rowHeight = 70;
        
        self.navigationItem.setRightBarButtonItem(infoBar, animated: false);
    }
    
    public override func didReceiveMemoryWarning() {
        
    }
    
}
