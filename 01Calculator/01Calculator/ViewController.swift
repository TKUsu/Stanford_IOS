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
    var userInput: Bool = false
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
        if userInput{
            display.text = textInDisplay! + digit!
        }else{
            display.text = digit!
            userInput = true
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func otherDigit(_ sender: UIButton) {
        if userInput{
            brain.setAccumulator(displayDouble)
            userInput = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        if let resule = brain.result {
            displayDouble = resule
        }
    }

}

