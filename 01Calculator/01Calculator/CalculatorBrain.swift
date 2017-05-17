//
//  CalculatorBrain.swift
//  01Calculator
//
//  Created by sujustin on 2017/5/17.
//  Copyright © 2017年 sujustin. All rights reserved.
//

import Foundation

//func changeSign(_ operation: Double) -> Double {
//    return -operation
//}

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "pi": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation({ -$0 }),
        "+": Operation.binaryOperation({(op1, op2) in return op1 + op2}),
        "-": Operation.binaryOperation({(op1, op2) in op1 - op2}),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "/": Operation.binaryOperation({ $0 / $1 }),
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let f):
                if accumulator != nil{
                    accumulator = f(accumulator!)
                }
            case .binaryOperation(let f):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: f, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    //mutating -> To change accumlator's value must add mutating
    mutating func setAccumulator(_ operand: Double) {
        accumulator = operand
    }
    //result(read only) is option, value possible is null
    var result: Double?{
        get{
            return accumulator
        }
    }
    
}
