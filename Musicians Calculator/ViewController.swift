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
    @IBOutlet weak var durationDisplay: UITableView!
    @IBOutlet private weak var bpmField: UITextField!
    @IBOutlet weak var divLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // limit view to portrait mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        durationDisplay.delegate = self
        durationDisplay.dataSource = self
        
        // add done button to keyboard - call endEditing() on bpmField when pressed
        bpmField.delegate = self
        bpmField.attributedPlaceholder = NSAttributedString(string: "Set BPM", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8705115914, green: 0.870637238, blue: 0.8704842329, alpha: 1)])
        bpmField.addDoneButtonToKeyboard(myAction: #selector(bpmField.endEditing(_:)))
        bpmField.keyboardType = .decimalPad
        bpmField.text = "120 BPM"
        
        // add tap recognizer and call handleTap() on double tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 2
        
        // load division array with values
        let names : [String] = ["1/1024", "1/512", "1/256", "1/128", "1/64", "1/16", "1/8", "1/4", "1/2", "1/1", "2/1", "4/1", "8/1", "16/1", "24/1"]
        for name in names {
            let division = Division(withName: name)
            divisions.append(division)
        }
        
        // set initial label values
        divLabel.text = "Note Value"
        timeLabel.text = "Time"
        
        // automatically scroll to center 1/4 note
        let indexOfQuarter = Int(names.firstIndex(of: "1/4")!)
        let indexPath = NSIndexPath(row: indexOfQuarter+1, section: 0)
        durationDisplay.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.middle, animated: true)
    }
    
    // limit BPM field input to numbers and a single decimal point
    private func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    
    @IBAction func editingDidBeginBPM(_ sender: Any) {
        bpmField.text = ""
    }
    
    // when editing finishes on the BPM field, update the BPM in the model and reload the Duration Display
    @IBAction private func editingDidEndBPM(_ sender: UITextField) {
        // if there are multiple decimal points, remove any characters after and including the second decimal point
        let input = sender.text ?? "0"
        var trimmedInput : String = ""
        var decimalCounter = 0
        for ch in input {
            if ch == "." {
                    decimalCounter += 1
            }
            if decimalCounter <= 1 {
                trimmedInput += String(ch)
            }
        }
        bpmField.text = trimmedInput + " BPM"
        // set BPM in Division with the trimmed input then update duration display
        let doubleBPM = Double(trimmedInput) ?? 0
        Division.setBPM(withbpm: doubleBPM)
        durationDisplay.reloadData()
    }
    
    // toggle between milliseconds and samples, called by tapGesture
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            showMilliseconds = (showMilliseconds ? false : true)
            if showMilliseconds {
                timeLabel.text = "Time"
            }
            else {
                timeLabel.text = "Samples"
            }
            durationDisplay.reloadData()
        }
    }
    
    // TODO: switch between normal, dotted, and triplet in Division, then update duration display
    
    // TODO: change the sample rate in Division, then update duration display
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return divisions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let div = divisions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DivisionCell") as! Cell
        var name : String = div.getName()
        if div.divValue >= 1.0 {
            name.removeLast(2)
            cell.divisionView.text = name + ((div.divValue == 1) ? " bar" : " bars")
        }
        else {
            cell.divisionView.text = name + " note"
        }
        cell.equals.text = "="
        if showMilliseconds {
            cell.timeView.text = ((div.ms >= 1000)
                        ? "\(String(format: "%.2f", div.ms/1000)) sec"
                        : "\(String(format: "%.2f", div.ms)) ms")
        }
        else {
            cell.timeView.text = ((div.samples >= 1000)
                        ? "\(String(format: "%.2f", div.samples/1000))k"
                        : "\(String(format: "%.2f", div.samples))")
        }
        return cell
    }
}
