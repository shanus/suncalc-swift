//
//  MoonTimes.swift
//  suncalc-example
//
//  Created by Shaun Meredith on 7/16/19.
//

import Foundation

class MoonTimes {
    var rise:Date?
    var set:Date?
    var alwaysUp:Bool
    var alwaysDown:Bool
    
    init(rise:Date?, set:Date?, alwaysUp:Bool, alwaysDown:Bool) {
        self.rise = rise
        self.set = set
        self.alwaysUp = alwaysUp
        self.alwaysDown = alwaysDown
    }
}
