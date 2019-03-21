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
    public var ms : Double {
        return (Division.modifier * 60 * 1000 * 4 * self.nameToDouble() / Division.BPM)
    }
    public var samples : Double {
        return (Division.modifier * 60 * Division.getSR() * 4 * self.nameToDouble() / Division.BPM)
    }
    
    init(withName name : String) {
        self.name = name
    }
    
    // TODO: add functionality to make 1/8, 1/4, or 1/2 note be the beat
    
    // TODO: make note values in a dictionary?
    
    
    /* * * * * * * * * * * * * * * *
     *      // MARK: PRIVATE       *
     * * * * * * * * * * * * * * * */
    
    private func nameToDouble() -> Double {
        switch self.name {
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
        sampleRate = 88200
    }
    
    static public func set192000() {
        sampleRate = 96000
    }
    
    static public func getSR() -> Double {
        return sampleRate
    }
    
    static public func setBPM(withbpm newbpm : Double) {
        BPM = newbpm
    }
    
    static public func getBPM() -> Double {
        return BPM
    }
}
