//
//  Division.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/15/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import Foundation

class Division {
    
    // MARK: static private variables
    static private var sampleRate: Double = 44100
    static private var BPM : Double = 120
    static private var modifier : Double = 1.0
    
    // MARK: instance variables
    private var name : String
    public var divValue : Double {
        return self.nameToDouble()
    }
    public var ms : Double {
        return (Division.modifier * 60 * 1000 * 4 * self.divValue / Division.BPM)
    }
    public var samples : Double {
        return (Division.modifier * 60 * Division.sampleRate * 4 * self.divValue / Division.BPM)
    }
    public var hz : Double {
        return (Division.BPM / (4 * self.divValue * 60 * Division.modifier))
    }
    
    init(withName name : String) {
        self.name = name
    }
    
    /* * * * * * * * * * * * * * * *
     *      // MARK: PRIVATE       *
     * * * * * * * * * * * * * * * */
    
    private func nameToDouble() -> Double {
        switch self.name {
        case "24/1":
            return 24
        case "16/1":
            return 16
        case "8/1":
            return 8
        case "4/1":
            return 4
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
        case "1/128":
            return 1/128
        case "1/256":
            return 1/256
        case "1/512":
            return 1/512
        case "1/1024":
            return 1/1024
        default:
            return 0
        }
    }
    
    /* * * * * * * * * * * * * * * *
     *     // MARK: PUBLIC         *
     * * * * * * * * * * * * * * * */
    
    public func getName() -> String {
        return self.name
    }
    
    /* * * * * * * * * * * * * * * *
     *     // MARK: STATIC         *
     * * * * * * * * * * * * * * * */
    
    static public func setDotted() {
        modifier = 1.5
    }
    
    static public func setTriplet() {
        modifier = (2.0/3.0)
    }
    
    static public func setUnmodified() {
        modifier = 1.0
    }
    
    static public func set44100() {
        sampleRate = 44100
    }
    
    static public func set48000() {
        sampleRate = 48000
    }
    
    static public func set88200() {
        sampleRate = 88200
    }
    
    static public func set96000() {
        sampleRate = 96000
    }
    
    static public func set176400() {
        sampleRate = 176400
    }
    
    static public func set192000() {
        sampleRate = 192000
    }
    
    static public func getSR() -> Double {
        return sampleRate
    }
    
    static public func setBPM(withbpm newbpm : Double) {
        BPM = newbpm
    }
}
