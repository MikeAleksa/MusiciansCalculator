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
    @IBOutlet private weak var durationDisplay: UILabel!
    @IBOutlet private weak var bpmField: UITextField!
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        // add done button to keyboard - call endEditing() on bpmField when pressed
        bpmField.delegate = self
        bpmField.addDoneButtonToKeyboard(myAction: #selector(bpmField.endEditing(_:)))
        bpmField.keyboardType = .decimalPad
        bpmField.text = "120"
        
        // add tap recognizer and call handleTap() on double tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 2
        
        // load division array with values
        for name in ["1/128", "1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1/1", "2/1", "4/1"] {
            let division = Division(withName: name)
            divisions.append(division)
            updateDuration(on: durationDisplay)
        }
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            showMilliseconds = (showMilliseconds ? false : true)
            updateDuration(on: durationDisplay)
        }
    }
    
    // TODO: switch between normal, dotted, and triplet
    
    // TODO: change duration display to be a table instead of a text field
    
    // limit BPM field input to numbers and decimal points
    // TODO: handle the possibility of the user trying to put in multiple decimal points?
    private func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    // when editing ends on the BPM field update the BPM in the model and reload the Duration Display
    @IBAction private func editingDidEndBPM(_ sender: UITextField) {
        let doubleBPM = Double(sender.text!) ?? 0
        Division.setBPM(withbpm: doubleBPM)
        updateDuration(on: durationDisplay)
    }
    
    // reload the Duration Display
    private func updateDuration(on label: UILabel) {
        durationDisplay.numberOfLines = 0
        var newLabel : String = ""
        for division in divisions {
            if (showMilliseconds) {
                newLabel += division.getName() + " note:\t  " + ((division.ms >= 1000)
                    ? String(format: "%.2f", division.ms/1000) + " sec\n"
                    : String(format: "%.2f", division.ms) + " ms\n")
            }
            else {
                newLabel += division.getName() + " note:\t  " + ((division.samples >= 1000)
                    ? String(format: "%.2", division.samples/1000) + "k samples\n"
                    : String(format: "%.0f", division.samples) + " samples\n")
            }
        }
        label.text = newLabel
    }
    
}
