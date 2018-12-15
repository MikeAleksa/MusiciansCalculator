//
//  SampleRate.swift
//  Musicians Calculator
//
//  Created by Michael Aleksa on 12/15/18.
//  Copyright © 2018 Michael Aleksa. All rights reserved.
//

import Foundation

struct SampleRate {
    
    private var sampleRate : Double = 44100
    
    /* * * * * * * * * * * * * * * *
     *           PUBLIC            *
     * * * * * * * * * * * * * * * */
    
    public mutating func set44100() {
        self.sampleRate = 44100
    }
    
    public mutating func set48000() {
        self.sampleRate = 48000
    }
    
    public mutating func set88200() {
        self.sampleRate = 88200
    }
    
    public mutating func set96000() {
        self.sampleRate = 96000
    }
}
