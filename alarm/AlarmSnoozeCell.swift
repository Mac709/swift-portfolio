//
//  AlarmSnoozeCell.swift
//  alarm
//
//  Created by nori nori on 2021/03/23.
//

import UIKit

protocol AlarmSnoozeCellDelegte {
    func alarmSnoozeCell(swichOn:AlarmSnoozeCell,On:Bool)
}

class AlarmSnoozeCell: UITableViewCell {

    @IBOutlet weak var snoozeSwitch: UISwitch!
    var delegate:AlarmSnoozeCellDelegte!
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        delegate.alarmSnoozeCell(swichOn: self, On: sender.isOn)
    }
}

