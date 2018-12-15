//
//  ViewController.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/14/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var calc = MusiciansCalculator()

    @IBOutlet weak var durationDisplay: UILabel!

    @IBOutlet weak var bpmField: UITextField!
    
    @IBAction func editBPM(_ sender: UITextField) {
        let doubleBPM = Double(sender.text!) ?? 0
        updateDuration(withbpm: doubleBPM, on: durationDisplay)
    }
    
    @IBAction func touchButton() {
        calc.setBPM(withbpm: 125)
        updateDuration(withbpm: calc.getBPM(), on: durationDisplay)    }
    
    func updateDuration(withbpm bpm: Double, on label: UILabel) {
        durationDisplay.numberOfLines = 8
        var newLabel : String = ""
        for division in calc.divisions {
            newLabel += division.getName() + " note:\t" + String(format: "%.2f", division.getMilliseconds()) + " ms\n"
        }
        label.text = newLabel
    }
    
    
}
