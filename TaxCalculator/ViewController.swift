//
//  ViewController.swift
//  TaxCalculator
//
//  Created by Aqeel Kamadia on 2017-02-26.
//  Copyright © 2017 Aqeel Kamadia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var checkoutItemsButton: UIButton!
    
    let numberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Tax Calculator"
        
        itemTextField.delegate = self
        itemTextField.becomeFirstResponder()
        
        costTextField.delegate = self
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        
        checkoutItemsButton.alpha = 0.5
        checkoutItemsButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Constants.sharedInstance.items.count == 0 {
            checkoutItemsButton.alpha = 0.5
            checkoutItemsButton.isEnabled = false
        }   else {
            checkoutItemsButton.alpha = 1
            checkoutItemsButton.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItemPressed(_ sender: Any) {
        guard let item = itemTextField.text, !item.isEmpty else {
            print("No item entered")
            return
        }
        guard let cost = costTextField.text, !cost.isEmpty else {
            print("No cost entered")
            return
        }
        
        Constants.sharedInstance.items.append(item)
        Constants.sharedInstance.costs.append(cost)
        itemTextField.text = ""
        costTextField.text = ""
        checkoutItemsButton.alpha = 1
        checkoutItemsButton.isEnabled = true
    }
    
    // UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case itemTextField:
            costTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == costTextField {
            var originalString = textField.text
        
            // Replace any formatting commas
            originalString = originalString!.replacingOccurrences(of: ",", with: "")
        
            var doubleFromString:  Double!
        
            if originalString!.isEmpty {
                originalString = string
                doubleFromString = Double(originalString!)
                doubleFromString! /= 100
            }   else {
                if string.isEmpty {
                    // Replace the last character for 0
                    let loc = originalString!.characters.count - 1
                    let range = NSMakeRange(loc, 1)
                    let newString = (originalString! as NSString).replacingCharacters(in: range, with: "0")
                    doubleFromString = Double(newString)
                    doubleFromString! /= 10
                }   else {
                    originalString = originalString! + string
                    doubleFromString = Double(originalString!)
                    doubleFromString! *= 10
                }
            
            }
            let finalString = numberFormatter.string(from: doubleFromString as NSNumber)
            textField.text = finalString
            return false
        }
        return true
    }

}

