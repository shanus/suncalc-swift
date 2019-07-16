//
//  GeocentricCoordinates.swift
//  suncalc-example
//
//  Created by Shaun Meredith on 10/2/14.
//

import Foundation

class GeocentricCoordinates {
	var rightAscension:Double;
	var declination:Double;
	var distance:Double;
	
	init(rightAscension:Double, declination:Double, distance:Double) {
		self.rightAscension = rightAscension
		self.declination = declination
		self.distance = distance
	}
}
