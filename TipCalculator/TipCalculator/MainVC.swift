//
//  MainVC.swift
//  TipCalculator
//
//  Created by Artem Losev on 4/4/16.
//  Copyright © 2016 Artem Losev. All rights reserved.
//

import UIKit

class MainVC: UIViewController,
                UITextFieldDelegate {
    
    
    @IBOutlet weak var sumEntry: UITextField!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var sliderVal: UISlider!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sumEntry.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Kept causing a weird error calling the sliderValue.value an Optional
    @IBAction func sliderChanged(sender: UISlider) {
        
        let curValue = Int(sender.value)
        
        // Display the value on the corresponding label
        
        percentageLabel.text = "\(curValue)%"
        
    }
    
    @IBAction func calculateTipTapped(sender: AnyObject) {
        if sumEntry.text == "" {
            sumEntry.text = "0.00"
        }
        
        let sum = Float(sumEntry.text!)
        let perc = Int(sliderVal.value)
        
        // Calculate the tip
        var tip = sum! * (Float(perc) / 100)
        let extra = (tip+sum!) % 1.00
        if extra > 0.50 {
            tip += (1.00 - extra)
        }
        else {
            tip -= extra
        }
        
        // Print the amounts
        tipAmount.text = "$" + String(tip)
        totalAmount.text = "$" + String(Int(sum! + tip))
        
        // Unhide the labels
        tipAmount.hidden = false
        totalAmount.hidden = false
        
        // Resign the keyboard
        sumEntry.resignFirstResponder()
        
    }
    
    
    
    // Get rid of the keyboard when touched outside the pad
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        sumEntry.resignFirstResponder()
    }
    

}
