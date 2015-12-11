//
//  ViewController.swift
//  TipCalculator
//
//  Created by Oranuch on 12/9/15.
//  Copyright © 2015 Oranuch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var tipPercentages = [0.18, 0.2, 0.22]
    
    @IBAction func onTapped(sender: AnyObject) {
        //dismiss the keyboard
        view.endEditing(true)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateAmounts()
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        updateAmounts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //animate the segmented control
        animateSegmentedControlLeftToMid()
        
        //set BillField to become the first responder
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //initialize the SegmentedControl if data is persisted
        let defaults = NSUserDefaults.standardUserDefaults()
        if let servicePercentDict = defaults.objectForKey("servicePercentDict") {
            initializeSegmentedControl(servicePercentDict as! [String : Double])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeSegmentedControl(servicePercentDict: [String: Double]) {
        tipControl.setTitle(formatPercent(servicePercentDict["Good"]!),
            forSegmentAtIndex: 0)
        tipControl.setTitle(formatPercent(servicePercentDict["Great"]!),
            forSegmentAtIndex: 1)
        tipControl.setTitle(formatPercent(servicePercentDict["Excellent"]!),
            forSegmentAtIndex: 2)
        
        tipPercentages[0] = servicePercentDict["Good"]!
        tipPercentages[1] = servicePercentDict["Great"]!
        tipPercentages[2] = servicePercentDict["Excellent"]!
    }
    
    func formatCurrency(amount: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter.stringFromNumber(amount)!
    }
    
    func formatPercent(percent: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        return formatter.stringFromNumber(percent)!
    }
    
    func updateAmounts() {
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = (billField.text! as NSString).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        tipLabel.text = formatCurrency(tip)
        totalLabel.text = formatCurrency(total)
    }
    
    func animateSegmentedControlLeftToMid() {
        tipControl.alpha = 0
        let tipControlXPosition = tipControl.frame.origin.x
        tipControl.frame.origin.x = -100
        UIView.animateWithDuration(1.5, animations: {
            self.tipControl.alpha = 1
            self.tipControl.frame.origin.x = tipControlXPosition
        })
    }

}

