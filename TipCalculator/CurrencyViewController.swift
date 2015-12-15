//
//  CurrencyViewController.swift
//  TipCalculator
//
//  Created by Oranuch on 12/14/15.
//  Copyright © 2015 Oranuch. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let currencies = [ ("USD","usdImage"), ("GBP","poundImage"), ("JPY","yenImage"), ("EUR","euroImage") ]
    
    var selectedCurrency: String!
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencies[row].0
        
        //save the selectedCurrency in the NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedCurrency, forKey: "selectedCurrency")
        defaults.synchronize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var currentPosition = 0
        if let currentCurrency = defaults.objectForKey("selectedCurrency") {
            for index in 0...currencies.count {
                if currentCurrency as! String == currencies[index].0 {
                    currentPosition = index
                    break
                }
            }
            currencyPicker.selectRow(currentPosition, inComponent: 0, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("currencyCell", forIndexPath: indexPath) as UITableViewCell
        let (currency, currencyImage) = currencies[indexPath.row]
        let cellImage = UIImage(imageLiteral: currencyImage)

        cell.textLabel!.text = currency
        cell.imageView!.image = cellImage
        return cell
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
