//
//  ViewController.swift
//  CalculatorUseSwift
//
//  Created by crx on 12/10/2016.
//  Copyright © 2016 XingLian. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

    @IBAction func addNumber(_ sender: UIButton) {
        let diget = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            
            display.text = display.text! + diget
        } else {
            display.text = diget
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    var operandStack = Array<Double>()
    
    
    @IBAction func enter(_ sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double{
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
        case "+":
            performOperation(operation: plus)
            break
        case "−":
            performOperation(operation: {(op1: Double, op2: Double) -> Double in
                return op1 - op2
            })
            break
        case "×":
            performOperation(operation: {$0 * $1})
            break
        case "÷":
            //如果参数是最后一个可以移到括号的外面
            performOperation{$1 / $0}
            break
        case "√":
            performOperation2{sqrt($0)}
            break
        default:
            break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter(UIButton())
        }
    }
    
    func performOperation2(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter(UIButton())
        }
    }
    
    func plus(op1: Double, op2: Double) -> Double {
        return op1 + op2
    }
}

