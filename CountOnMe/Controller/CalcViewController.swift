//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

/* todo:
 - nombre entier sans entier (number formatteur)
 - division par 0 et d'autres scénarios
 - ✅ model (manipulation): symbols/opérateurs dans un enum
 rajouter egale dans enum
 - utiliser un guard (tap Equal)
 */

import UIKit

class CalcViewController: UIViewController, SimpleCalcView {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    lazy var simpleCalc = SimpleCalc(view: self)
    
    override func viewDidLoad() { super.viewDidLoad() }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        simpleCalc.tapNumber(sender: sender)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        simpleCalc.executeCalc(with: Operands.plus)
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        simpleCalc.executeCalc(with: Operands.less)
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        simpleCalc.executeCalc(with: Operands.multiply)
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        simpleCalc.executeCalc(with: Operands.divide)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        simpleCalc.tapEqual()
    }
}

