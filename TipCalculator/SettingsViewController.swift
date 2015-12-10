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
        print("Output: \(servicePercentDict[serviceTypes[row]]!) selected")
        //do logics to switch-case service type
        currentTypeService = row
        percentDisplay.text = String(format: "%.2f", servicePercentDict[serviceTypes[row]]! )
        
        
    }
    
    @IBAction func onStepped(sender: AnyObject) {
        percentDisplay.text = "\(percentStepper.value)"
        servicePercentDict[serviceTypes[currentTypeService]] = percentStepper.value
        updateSettingsLabels()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateSettingsLabels()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSettingsLabels() {
        goodLabel.text = String(format: "%.2f", servicePercentDict["Good"]!)
        greatLabel.text = String(format: "%.2f", servicePercentDict["Great"]!)
        excellentLabel.text = String(format: "%.2f", servicePercentDict["Excellent"]!)
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
