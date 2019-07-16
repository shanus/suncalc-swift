//
//  DateUtils.swift
//  suncalc-example
//
//  Created by Shaun Meredith on 10/2/14.
//

import Foundation


let DAY_SECONDS:Double = 60 * 60 * 24
let J1970:Double = 2440588
let J2000:Double = 2451545

class DateUtils {
	
	class func toJulian(date:Date) -> Double {
		return Double(date.timeIntervalSince1970) / DAY_SECONDS - 0.5 + J1970
	}
	
	class func fromJulian(j:Double) -> Date {
		let timeInterval = (j + 0.5 - J1970) * DAY_SECONDS
		return Date(timeIntervalSince1970: timeInterval)
	}
	
	class func toDays(date:Date) -> Double {
        return DateUtils.toJulian(date: date) - J2000
	}
    
    class func getHoursLater(date:Date, hours:Double) -> Date? {
        let calendar:Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(byAdding: .second, value: Int(hours*60*60), to: date)
    }
}
