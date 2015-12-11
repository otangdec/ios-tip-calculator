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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //initialize the SegmentedControl if data is persisted
        let defaults = NSUserDefaults.standardUserDefaults()
        if let servicePercentDict = defaults.objectForKey("servicePercentDict") {
            tipControl.setTitle(formatPercent(servicePercentDict["Good"] as! Double), forSegmentAtIndex: 0)
            tipControl.setTitle(formatPercent(servicePercentDict["Great"] as! Double), forSegmentAtIndex: 1)
            tipControl.setTitle(formatPercent(servicePercentDict["Excellent"] as! Double), forSegmentAtIndex: 2)
            
            tipPercentages[0] = servicePercentDict["Good"] as! Double
            tipPercentages[1] = servicePercentDict["Great"] as! Double
            tipPercentages[2] = servicePercentDict["Excellent"] as! Double
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


}

