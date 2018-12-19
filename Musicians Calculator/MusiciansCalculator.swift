//
//  MusiciansCalculator.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/15/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import Foundation

class MusiciansCalculator : SampleRate {
    
    private var bpm : Double {
        didSet {
            self.updateDivisions()
        }
    }
    
    private var modifier : Double {
        didSet {
            self.updateDivisions()
        }
    }
    
    override init() {
        bpm = 120
        modifier = 1.0
        for name in ["1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1/1", "2/1"] {
            let division = Division(withName: name, withbpm: bpm, withsr: MusiciansCalculator.getSR(), withMod: modifier)
            divisions.append(division)
        }
    }
    
    /* * * * * * * * * * * * * * * *
     *           PRIVATE           *
     * * * * * * * * * * * * * * * */
    
    private func updateDivisions() {
        for division in divisions {
            division.updateTimes(withbpm: bpm, withsr: MusiciansCalculator.getSR(), withMod: modifier)
        }
    }
    
    /* * * * * * * * * * * * * * * *
     *           PUBLIC            *
     * * * * * * * * * * * * * * * */
    
    public var divisions = [Division]()
    
    public func setBPM(withbpm bpm : Double) {
        self.bpm = bpm
    }

    public func getBPM() -> Double {
        return self.bpm
    }
    
    public func setDotted() {
        self.modifier = 1.5
    }
    
    public func setTriplet() {
        self.modifier = (2.0/3.0)
    }
    
    public func setUnmodified() {
        self.modifier = 1.0
    }
}


