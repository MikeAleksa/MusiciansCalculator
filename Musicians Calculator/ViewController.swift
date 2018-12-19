//
//  ViewController.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/14/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var divisions = [Division]()
    var showMilliseconds = true
    
    @IBOutlet weak var durationDisplay: UILabel!
    @IBOutlet weak var bpmField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bpmField.delegate = self
        bpmField.keyboardType = .decimalPad
        
        for name in ["1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1/1", "2/1"] {
            let division = Division(withName: name)
            divisions.append(division)
        }
    }
    
    // limit BPM field input to numbers and a decimal point
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    // when BPM field is updated, update the BPM in the model and reload the Duration Display
    @IBAction func editBPM(_ sender: UITextField) {
        let doubleBPM = Double(sender.text!) ?? 0
        Division.setBPM(withbpm: doubleBPM)
        updateDuration(withbpm: doubleBPM, on: durationDisplay)
    }

    // reload the Duration Display
    func updateDuration(withbpm bpm: Double, on label: UILabel) {
        durationDisplay.numberOfLines = 0
        var newLabel : String = ""
        for division in divisions {
            if (showMilliseconds) {
                newLabel += division.getName() + " note:\t" + String(format: "%.2f", division.getMilliseconds()) + " ms\n"
            }
            else {
                newLabel += division.getName() + " note:\t" + String(format: "%.0f", division.getSamples()) + " ms\n"
            }
        }
        label.text = newLabel
    }
    
}
