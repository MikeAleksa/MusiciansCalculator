//
//  ViewController.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/14/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var divisions = [Division]()

    override func viewDidLoad() {
        for name in ["1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1/1", "2/1"] {
            let division = Division(withName: name)
            divisions.append(division)
        }
    }
    
    @IBOutlet weak var durationDisplay: UILabel!

    @IBOutlet weak var bpmField: UITextField!
    
    @IBAction func editBPM(_ sender: UITextField) {
        let doubleBPM = Double(sender.text!) ?? 0
        Division.setBPM(withbpm: doubleBPM)
        updateDuration(withbpm: doubleBPM, on: durationDisplay)
    }

    func updateDuration(withbpm bpm: Double, on label: UILabel) {
        durationDisplay.numberOfLines = 0
        var newLabel : String = ""
        for division in divisions {
            newLabel += division.getName() + " note:\t" + String(format: "%.2f", division.getMilliseconds()) + " ms\n"
        }
        label.text = newLabel
    }
    
}
