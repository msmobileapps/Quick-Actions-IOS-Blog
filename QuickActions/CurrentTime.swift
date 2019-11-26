//
//  CurrentTime.swift
//  QuickActions
//
//  Created by Daniel Radshun on 24/11/2019.
//  Copyright © 2019 Daniel Radshun. All rights reserved.
//

import Foundation

class CurrentTime {
    
    static let shared = CurrentTime()

    var hours:Int = 0 {
           didSet{
               UserDefaults.standard.set(hours, forKey: "Hours")
           }
       }
    var minutes:Int = 0 {
           didSet{
               UserDefaults.standard.set(minutes, forKey: "Minutes")
           }
       }
    
    private init() {
        let hours = UserDefaults.standard.integer(forKey: "Hours")
        let minutes = UserDefaults.standard.integer(forKey: "Minutes")
        self.hours = hours
        self.minutes = minutes
    }
}
