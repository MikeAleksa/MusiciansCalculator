//
//  ViewController.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/14/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import UIKit

// extension to add a "done" button to the decimal pad
// from https://stackoverflow.com/questions/38133853/how-to-add-a-return-key-on-a-decimal-pad-in-swift
extension UITextField{
    
    func addDoneButtonToKeyboard(myAction: Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: variables
    private var divisions = [Division]()
    private(set) var showMilliseconds = true
    
    // MARK: outlets
    @IBOutlet weak var divisionDisplay: UITableView!
    @IBOutlet weak var durationDisplay: UITableView!
    @IBOutlet private weak var bpmField: UITextField!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        // add done button to keyboard - call endEditing() on bpmField when pressed
        bpmField.delegate = self
        bpmField.attributedPlaceholder = NSAttributedString(string: "Set BPM", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8705115914, green: 0.870637238, blue: 0.8704842329, alpha: 1)])
        bpmField.addDoneButtonToKeyboard(myAction: #selector(bpmField.endEditing(_:)))
        bpmField.keyboardType = .decimalPad
        bpmField.text = "120"
        
        // add tap recognizer and call handleTap() on double tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 2
        
        // load division array with values
        for name in ["1/128",
                     "1/64",
                     "1/32",
                     "1/16",
                     "1/8",
                     "1/4",
                     "1/2",
                     "1/1",
                     "2/1",
                     "4/1"] {
            let division = Division(withName: name)
            divisions.append(division)
            updateDuration()
        }
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            showMilliseconds = (showMilliseconds ? false : true)
            updateDuration()
        }
    }
    
    // TODO: switch between normal, dotted, and triplet
    
    // TODO: change duration display to be a table instead of a text field
    
    // TODO: limit BPM field input to numbers and a single decimal point
    private func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    // when editing finishes on the BPM field, update the BPM in the model and reload the Duration Display
    @IBAction private func editingDidEndBPM(_ sender: UITextField) {
        // remove any decimal points after first decimal point and update the BPM field
        let input = sender.text ?? "0"
        var set = Set<Character>()
        let trimmed = input.filter{ set.insert($0).inserted }
        bpmField.text = trimmed + " BPM"
        // set BPM with the trimmed input and update duration
        let doubleBPM = Double(trimmed) ?? 0
        Division.setBPM(withbpm: doubleBPM)
        updateDuration()
    }
    
    // reload the Duration Display
    private func updateDuration() {
        var newLabel : String = ""
        for division in divisions {
            let name = division.getName()
                if (showMilliseconds) {
                    newLabel += "\(name) note:\t\t" + ((division.ms >= 1000)
                        ? "\(String(format: "%.2f", division.ms/1000)) sec\n"
                        : "\(String(format: "%.2f", division.ms)) ms\n")
                }
                else {
                    newLabel += "\(name) note:\t\t" + ((division.samples >= 1000)
                        ? "\(String(format: "%.2", division.samples/1000))k samples\n"
                        : "\(String(format: "%.0f", division.samples)) samples\n")
                }
        }
//        durationDisplay.text = newLabel
    }
}
