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
    let names : [String] = ["1/1024", "1/512", "1/256", "1/128", "1/64", "1/16", "1/8", "1/4", "1/2", "1/1", "2/1", "4/1", "8/1", "16/1", "24/1"]
    
    // MARK: outlets
    @IBOutlet weak var durationDisplay: UITableView!
    @IBOutlet private weak var bpmField: UITextField!
    @IBOutlet weak var divLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    // limit view to portrait mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // make status bar style light
    override var preferredStatusBarStyle: UIStatusBarStyle {
              return .lightContent
        }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        durationDisplay.delegate = self
        durationDisplay.dataSource = self
        durationDisplay.keyboardDismissMode = .onDrag
        
        // add done button to keyboard - call endEditing() on bpmField when pressed
        bpmField.delegate = self
        bpmField.attributedPlaceholder = NSAttributedString(string: "Set BPM", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8705115914, green: 0.870637238, blue: 0.8704842329, alpha: 1)])
        bpmField.keyboardType = UIKeyboardType.decimalPad
        bpmField.addDoneButtonToKeyboard(myAction: #selector(bpmField.endEditing(_:)))
        bpmField.text = "120 BPM"
        
        // add tap recognizer and call handleTap() on double tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 2
        
        // load division array with values
        for name in names {
            divisions.append(Division(withName: name))
        }
        
        // set initial label values and make footer to remove extra rows in table
        divLabel.text = "Note Value"
        timeLabel.text = "Time"
        self.durationDisplay.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // automatically scroll to 1/4 note
        let indexOfQuarter = Int(names.firstIndex(of: "1/4")!)
        let indexPath = IndexPath(row: indexOfQuarter, section: 0)
        durationDisplay.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: false)
    }
    
    // limit BPM field input to numbers and a single decimal point
    private func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    // clear BPM field at start of editing
    @IBAction func editingDidBeginBPM(_ sender: UITextField) {
        DispatchQueue.main.async { [weak self] in
            self?.bpmField.text = "" }
    }
    
    // when editing finishes on the BPM field, update the BPM in the model and reload the Duration Display
    @IBAction private func editingDidEndBPM(_ sender: UITextField) {
        DispatchQueue.main.async { [weak self] in
            let input = sender.text ?? "Set BPM"
            if input != "Set BPM" && input != "" {
                // if there are multiple decimal points, remove any characters after and including the second decimal point
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
                self?.bpmField.text = trimmedInput + " BPM"
                // set BPM in Division with the trimmed input then update duration display
                let doubleBPM = Double(trimmedInput) ?? 0
                Division.setBPM(withbpm: doubleBPM)
            }
            // if nothing was entered in the BPM field, reset to 120 BPM
            else {
                self?.bpmField.text = "120 BPM"
                Division.setBPM(withbpm: 120)
            }
            self?.durationDisplay.reloadData()
        }
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
            DispatchQueue.main.async { [weak self] in self?.durationDisplay.reloadData() }
        }
    }
    
    // switch between normal, dotted, and triplet in Division, then update duration display
    @IBAction func changeModifier(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            Division.setUnmodified()
        case 1:
            Division.setTriplet()
        case 2:
            Division.setDotted()
        default:
            Division.setUnmodified()
        }
        DispatchQueue.main.async { [weak self] in self?.durationDisplay.reloadData() }
    }
    
    // change the sample rate in Division, then update duration display
    @IBAction func changeSampleRate(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            Division.set44100()
        case 1:
            Division.set48000()
        case 2:
            Division.set88200()
        case 3:
            Division.set96000()
        case 4:
            Division.set176400()
        case 5:
            Division.set192000()
        default:
            Division.set44100()
        }
        if showMilliseconds == false {
            DispatchQueue.main.async { [weak self] in self?.durationDisplay.reloadData() }
        }
    }
}

// populate the table from information derived from divisions
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return divisions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let div = divisions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DivisionCell") as! Cell
        var name : String = div.getName()
        DispatchQueue.main.async { [weak self] in
            if div.divValue >= 1.0 {
                name.removeLast(2)
                cell.divisionView.text = name + ((div.divValue == 1) ? " bar" : " bars")
            }
            else {
                cell.divisionView.text = name + " note"
            }
            cell.equals.text = "="
            if (self?.showMilliseconds)! {
                cell.timeView.text = ((div.ms >= 1000)
                            ? "\(String(format: "%.2f", div.ms/1000)) sec"
                            : "\(String(format: "%.2f", div.ms)) ms")
            }
            else {
                cell.timeView.text = ((div.samples >= 1000)
                            ? "\(String(format: "%.2f", div.samples/1000))k"
                            : "\(String(format: "%.2f", div.samples))")
            }
        }
        return cell
    }
}
