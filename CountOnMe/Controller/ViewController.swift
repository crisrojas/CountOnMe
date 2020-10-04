//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    // ExpressionIsCorrect  == canAddOperator
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        /// Clears the textView if its content have a result (tappedEqualButton)
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        executeCalc(with: " + ")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        executeCalc(with: " - ")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        executeCalc(with: " x ")
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        executeCalc(with: " ÷ ")
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            return presentErrorAlert(with: "Entrez une expression correcte!")
        }
        
        guard expressionHaveEnoughElement else {
            return presentErrorAlert(with: "Démarrez un nouveau calcul!")
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            
            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }
    
    private func executeCalc(with operand: String) {
        if canAddOperator {
            textView.text.append(operand)
        } else {
            presentErrorAlert(with: "Un operateur est déja mis!")
        }
    }
    
    private func presentErrorAlert(with message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    

}

