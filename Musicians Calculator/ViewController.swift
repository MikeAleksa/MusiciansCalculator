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
        calc.setBPM(withbpm: doubleBPM)
        updateDuration(withbpm: doubleBPM, on: durationDisplay)
    }

    
    func updateDuration(withbpm bpm: Double, on label: UILabel) {
        durationDisplay.numberOfLines = 0
        var newLabel : String = ""
        for division in calc.divisions {
            newLabel += division.getName() + " note:\t" + String(format: "%.2f", division.getMilliseconds()) + " ms\n"
        }
        label.text = newLabel
    }
    
    
}
