//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Oranuch on 12/9/15.
//  Copyright © 2015 Oranuch. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var percentStepper: UIStepper!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var greatLabel: UILabel!
    @IBOutlet weak var excellentLabel: UILabel!
    @IBOutlet weak var serviceTypePicker: UIPickerView!
    @IBOutlet weak var percentDisplay: UILabel!
    
    let serviceTypes = ["Good", "Great", "Excellent"]
    var servicePercentDict = ["Good": 0.15, "Great": 0.18, "Excellent": 0.25]
    var currentTypeService = 0
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return serviceTypes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return serviceTypes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //save the index of the selected row
        currentTypeService = row
        
        percentStepper.value = servicePercentDict[serviceTypes[currentTypeService]]!
        percentDisplay.text = formatPercent(percentStepper.value)
    }
    
    @IBAction func onStepped(sender: AnyObject) {
        percentDisplay.text = formatPercent(percentStepper.value)
        servicePercentDict[serviceTypes[currentTypeService]] = percentStepper.value
        updateSettingsLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateSettingsLabels()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //initialize the servicePercenDict if data was persisted
        let defaults = NSUserDefaults.standardUserDefaults()
        if let savedDict = defaults.objectForKey("servicePercentDict") {
            servicePercentDict = savedDict as! [String : Double]
            updateSettingsLabels()
            let stepValue = savedDict[serviceTypes[currentTypeService]] as! Double
            percentStepper.value = stepValue
            percentDisplay.text = formatPercent(stepValue)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //persist the tip percentages to the NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(servicePercentDict, forKey: "servicePercentDict")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSettingsLabels() {
        goodLabel.text = formatPercent(servicePercentDict["Good"]!)
        greatLabel.text = formatPercent(servicePercentDict["Great"]!)
        excellentLabel.text = formatPercent(servicePercentDict["Excellent"]!)
        
    }
    
    func formatPercent(percent: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        return formatter.stringFromNumber(percent)!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
