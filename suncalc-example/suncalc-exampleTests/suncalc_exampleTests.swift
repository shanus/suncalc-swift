//
//  suncalc_exampleTests.swift
//  suncalc-exampleTests
//
//  Created by Shaun Meredith on 10/2/14.
//  Copyright (c) 2014 Chimani, LLC. All rights reserved.
//

import UIKit
import XCTest

let NEARNESS = 1e-9

class suncalc_exampleTests: XCTestCase {
	var date:NSDate = NSDate()
	var LAT:Double = 50.5
	var LNG:Double = 30.5
	
	override func setUp() {
		super.setUp()
		let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
		calendar.timeZone = NSTimeZone(abbreviation: "GMT")!
		let components:NSDateComponents = NSDateComponents()
		components.year = 2013
		components.month = 3
		components.day = 5
		
		self.date = calendar.dateFromComponents(components)!
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func test_sun_getTimes() {
		let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: LAT, longitude: LNG)
		
		let formatter:NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		formatter.timeZone = NSTimeZone(abbreviation: "GMT")
		
		XCTAssertEqual(formatter.stringFromDate(sunCalc.solarNoon),						"2013-03-05T10:10:57Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.nadir),								"2013-03-04T22:10:57Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.sunrise),							"2013-03-05T04:34:57Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.sunset),								"2013-03-05T15:46:56Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.sunriseEnd),						"2013-03-05T04:38:19Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.sunsetStart),					"2013-03-05T15:43:34Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.dawn),									"2013-03-05T04:02:17Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.dusk),									"2013-03-05T16:19:36Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.nauticalDawn),					"2013-03-05T03:24:31Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.nauticalDusk),					"2013-03-05T16:57:22Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.nightEnd),							"2013-03-05T02:46:17Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.night),								"2013-03-05T17:35:36Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.goldenHourEnd),				"2013-03-05T05:19:01Z")
		XCTAssertEqual(formatter.stringFromDate(sunCalc.goldenHour),						"2013-03-05T15:02:52Z")
	}
	
	func test_sun_getPosition() {
		let sunPos:SunPosition = SunCalc.getSunPosition(date, latitude: LAT, longitude: LNG)
		XCTAssertEqualWithAccuracy(sunPos.azimuth, -2.5003175907168385, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(sunPos.altitude, -0.7000406838781611, accuracy: NEARNESS)
	}
	
	func test_getMoonPosition() {
		let moonPos:MoonPosition = SunCalc.getMoonPosition(date, latitude: LAT, longitude: LNG)
		XCTAssertEqualWithAccuracy(moonPos.azimuth, -0.9783999522438226, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(moonPos.altitude, 0.006969727754891917, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(moonPos.distance, 364121.37256256294, accuracy: NEARNESS)
	}
	
	func test_getMoonIllumination() {
		let moonIllum:MoonIllumination = SunCalc.getMoonIllumination(date)
		XCTAssertEqualWithAccuracy(moonIllum.fraction, 0.4848068202456373, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(moonIllum.phase, 0.7548368838538762, accuracy: NEARNESS)
		XCTAssertEqualWithAccuracy(moonIllum.angle, 1.6732942678578346, accuracy: NEARNESS)
	}
	
	func test_README_example() {
		let date:NSDate = NSDate()
		let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: 51.5, longitude: -0.1)
		
		let formatter:NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "HH:mm"
		formatter.timeZone = NSTimeZone(abbreviation: "GMT")
		let sunriseString:String = formatter.stringFromDate(sunCalc.sunrise)
		print("sunrise is at \(sunriseString)")
		
		let sunPos:SunPosition = SunCalc.getSunPosition(date, latitude: 51.5, longitude: -0.1)
		
		let sunriseAzimuth:Double = sunPos.azimuth * 180 / Constants.PI()
		print("sunrise azimuth: \(sunriseAzimuth)")
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
