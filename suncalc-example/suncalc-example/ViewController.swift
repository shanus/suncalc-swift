//
//  ViewController.swift
//  suncalc-example
//
//  Created by Shaun Meredith on 10/2/14.
//  Copyright (c) 2014 Chimani, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var timeLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let date:NSDate = NSDate()
		let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: 51.5, longitude: -0.1)
		
		let formatter:NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "HH:mm"
		formatter.timeZone = NSTimeZone(abbreviation: "GMT")
		let sunriseString:String = formatter.stringFromDate(sunCalc.sunrise)
		timeLabel.text = sunriseString
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

