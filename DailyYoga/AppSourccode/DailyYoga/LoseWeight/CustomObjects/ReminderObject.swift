//
//  ExcerciseCell.swift
//  LoseWeight
//
//  Created by Sprint on 04/12/2018.
//  Copyright © 2018 Sprint Solutions. All rights reserved.
//

import UIKit

class ReminderObject: NSObject, NSCoding
{
    var remID: String!
    var status:String!
    var title:String!
    var daysStr:String!
    var timeStr:String!
    var sunFlag:Bool!
    var monFlag:Bool!
    var tueFlag:Bool!
    var wedFlag:Bool!
    var thuFlag:Bool!
    var friFlag:Bool!
    var satFlag:Bool!
    
    init(remID: String,status: String, title: String, daysStr: String, timeStr: String, sunFlag: Bool, monFlag: Bool, tueFlag: Bool, wedFlag: Bool, thuFlag: Bool, friFlag: Bool, satFlag: Bool) {
        self.remID = remID
        self.status = status
        self.title = title
        self.daysStr = daysStr
        self.timeStr = timeStr
        self.sunFlag = sunFlag
        self.monFlag = monFlag
        self.tueFlag = tueFlag
        self.wedFlag = wedFlag
        self.thuFlag = thuFlag
        self.friFlag = friFlag
        self.satFlag = satFlag
    }
    
    required convenience init(coder aDecoder: NSCoder)
    {
        let remID = aDecoder.decodeObject(forKey: "remID") as! String
        let status = aDecoder.decodeObject(forKey: "status") as! String
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let daysStr = aDecoder.decodeObject(forKey: "daysStr") as! String
        let timeStr = aDecoder.decodeObject(forKey: "timeStr") as! String
        let sunFlag = aDecoder.decodeObject(forKey: "sunFlag") as! Bool
        let monFlag = aDecoder.decodeObject(forKey: "monFlag") as! Bool
        let tueFlag = aDecoder.decodeObject(forKey: "tueFlag") as! Bool
        let wedFlag = aDecoder.decodeObject(forKey: "wedFlag") as! Bool
        let thuFlag = aDecoder.decodeObject(forKey: "thuFlag") as! Bool
        let friFlag = aDecoder.decodeObject(forKey: "friFlag") as! Bool
        let satFlag = aDecoder.decodeObject(forKey: "satFlag") as! Bool
        
        self.init(remID: remID, status:status, title: title, daysStr: daysStr, timeStr: timeStr, sunFlag: sunFlag, monFlag:monFlag, tueFlag:tueFlag, wedFlag:wedFlag, thuFlag:thuFlag, friFlag:friFlag, satFlag:satFlag)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(remID, forKey: "remID")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(daysStr, forKey: "daysStr")
        aCoder.encode(timeStr, forKey: "timeStr")
        aCoder.encode(sunFlag, forKey: "sunFlag")
        aCoder.encode(monFlag, forKey: "monFlag")
        aCoder.encode(tueFlag, forKey: "tueFlag")
        aCoder.encode(wedFlag, forKey: "wedFlag")
        aCoder.encode(thuFlag, forKey: "thuFlag")
        aCoder.encode(friFlag, forKey: "friFlag")
        aCoder.encode(satFlag, forKey: "satFlag")
    }
}
