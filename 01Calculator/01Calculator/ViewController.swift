//
//  ViewController.swift
//  01Calculator
//
//  Created by sujustin on 2017/5/17.
//  Copyright © 2017年 sujustin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var firstInput: Bool = true
    var displayDouble: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle
        let textInDisplay = display.text
        if firstInput{
            display.text = digit!
            firstInput = false
        }else{
            display.text = textInDisplay! + digit!
        }
    }
    
    @IBAction func otherDigit(_ sender: UIButton) {
        firstInput = true
        
        if let mathematicalSymbol = sender.currentTitle{
            switch mathematicalSymbol {
            case "pi":
                displayDouble = Double.pi
            case "squre":
                displayDouble = sqrt(displayDouble)
            default:
                break
            }
        }
    }

}

