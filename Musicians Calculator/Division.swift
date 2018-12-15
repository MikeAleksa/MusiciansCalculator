//
//  Division.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/15/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import Foundation

class Division {

    static var dot : Bool = false
    static var triplet : Bool = false

    private var name : String
    private var ms : Double = 0
    private var samples : Double = 0

    init(withName name : String, withbpm bpm : Double) {
        self.name = name
        self.ms = calculateMilliseconds(withbpm: bpm)
        self.samples = calculateSamples(withbpm: bpm)
    }
    
    /* * * * * * * * * * * * * * * *
     *           PRIVATE           *
     * * * * * * * * * * * * * * * */
    
    private func calculateMilliseconds(withbpm bpm : Double) -> Double {
        // BPM * 60 sec/min * 1000 ms/sec * 4 beats/bar * division = Length of Division in milliseconds
        return bpm * 60 * 1000 * 4 * self.nameToDouble()
    }
    
    private func calculateSamples(withbpm bpm : Double) -> Double {
        // BPM * 60 sec/min * (n) samples/sec * 4 beats/bar * division = Length of Division in samples
        return bpm * 60 * 1000 * 4 * self.nameToDouble()
    }
    
    private func nameToDouble() -> Double {
        switch self.name {
        case "2/1":
            return 2
        case "1/1":
            return 1
        case "1/2":
            return 1/2
        case "1/4":
            return 1/4
        case "1/8":
            return 1/8
        case "1/16":
            return 1/16
        case "1/32":
            return 1/32
        case "1/64":
            return 1/64
        default:
            return 0
        }
    }
    
    /* * * * * * * * * * * * * * * *
     *           PUBLIC            *
     * * * * * * * * * * * * * * * */
    
    public func updateTimes(withbpm bpm: Double) {
        self.ms = calculateMilliseconds(withbpm: bpm)
        self.samples = calculateSamples(withbpm: bpm)

    }
  
    public func getName() -> String {
        return self.name
    }
    
    public func getMilliseconds() -> Double {
        return self.ms
    }
    
    public func getSamples() -> Double {
        return self.samples
    }
}
