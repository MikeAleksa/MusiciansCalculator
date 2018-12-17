//
//  SampleRate.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/15/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import Foundation

class SampleRate {
    
    static private var sampleRate : Double = 44100
    
    /* * * * * * * * * * * * * * * *
     *           PUBLIC            *
     * * * * * * * * * * * * * * * */
    
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
    
    static public func getSR() -> Double {
        return sampleRate
    }
}

