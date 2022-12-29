//
//  AlarmTimeArray.swift
//  alarm
//
//  Created by nori nori on 2021/03/21.
//

import UIKit

class AlarmTimeArray : NSObject, NSCoding {
    
    var date : Date
    var uuidString : String
    var label : String
    var sound : Bool
    var snooze : Bool
    var onOff : Bool
    var repeatLabel : String
    var week : [String]
    
    override init() {
        self.date = Date()
        self.uuidString = UUID().uuidString
        self.label = "Alarm"
        self.sound = true
        self.snooze = true
        self.onOff = true
        self.repeatLabel = "Never"
        self.week = []
    }
    
    func encode(with aCoder : NSCoder) {
        aCoder.encode(self.date, forKey : "date")
        aCoder.encode(self.uuidString, forKey : "uuidStrieg")
        aCoder.encode(self.label, forKey : "label")
        aCoder.encode(self.sound, forKey : "sound")
        aCoder.encode(self.snooze, forKey : "snooze")
        aCoder.encode(self.onOff, forKey : "onOff")
        aCoder.encode(self.repeatLabel, forKey : "repeatLable")
        aCoder.encode(self.week, forKey : "week")
    }
    
    required init?(coder aDecoder : NSCoder) {
        date = aDecoder.decodeObject(forKey : "date") as! Date
        uuidString = aDecoder.decodeObject(forKey : "uuidString") as! String
        label = aDecoder.decodeObject(forKey : "lable") as! String
        sound = aDecoder.decodeBool(forKey : "sound")
        snooze = aDecoder.decodeBool(forKey : "snooze")
        onOff = aDecoder.decodeBool(forKey : "onOff")
        repeatLabel = aDecoder.decodeObject(forKey : "repeatLabel") as! String
        week = aDecoder.decodeObject(forKey : "week") as! [String]
    }
}
