//
//  Division.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/15/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import Foundation

class Division : SampleRate {

    private var name : String

    init(withName name : String) {
        self.name = name
    }
    
    /* * * * * * * * * * * * * * * *
     *           PRIVATE           *
     * * * * * * * * * * * * * * * */
    
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
    
    public func getName() -> String {
        return self.name
    }
    
    public func getMilliseconds() -> Double {
        return (Division.modifier * 60 * 1000 * 4 * self.nameToDouble() / Division.bpm)
    }
    
    public func getSamples() -> Double {
        return (Division.modifier * 60 * SampleRate.getSR() * 4 * self.nameToDouble() / Division.bpm)
    }
    
    /* * * * * * * * * * * * * * * *
     *           STATIC            *
     * * * * * * * * * * * * * * * */
    
    static private var bpm : Double = 120
    static private var modifier : Double = 1.0
    
    static public func setBPM(withbpm newbpm : Double) {
        bpm = newbpm
    }

    static public func getBPM() -> Double {
        return bpm
    }
    
    static public func setDotted() {
        modifier = 1.5
    }
    
    static public func setTriplet() {
        modifier = (2.0/3.0)
    }
    
    static public func setUnmodified() {
        modifier = 1.0
    }
}
