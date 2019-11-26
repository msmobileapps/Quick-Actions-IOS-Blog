//
//  ViewController.swift
//  QuickActions
//
//  Created by Daniel Radshun on 24/11/2019.
//  Copyright © 2019 Daniel Radshun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let currentTime = CurrentTime.shared
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        let hours = comp.hour
        let minutes = comp.minute
        
        currentTime.hours = hours!
        currentTime.minutes = minutes!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let dateWithHours = calendar.date(bySetting: .hour, value: currentTime.hours, of: date) ?? Date()
        let dateWithMinutesAndHours = calendar.date(bySetting: .minute, value: currentTime.minutes, of: dateWithHours) ?? Date()
        timePicker.setDate(dateWithMinutesAndHours, animated: true)
    }


}

