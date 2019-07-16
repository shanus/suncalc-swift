//
//  SunUtils.swift
//  suncalc-example
//
//  Created by Shaun Meredith on 10/2/14.
//

import Foundation

class SunUtils {
	
	class func getSolarMeanAnomaly(d:Double) -> Double {
		return Constants.RAD() * (357.5291 + 0.98560028 * d)
	}
	
	class func getEquationOfCenter(M:Double) -> Double {
        let firstFactor = 1.9148 * sin(M)
        let secondFactor = 0.02 * sin(2 * M)
        let thirdFactor = 0.0003 * sin(3 * M)
		return Constants.RAD() * (firstFactor + secondFactor + thirdFactor)
	}
	
	class func getEclipticLongitudeM(M:Double) -> Double {
        let C:Double = SunUtils.getEquationOfCenter(M:M)
		let P:Double = Constants.RAD() * 102.9372 // perihelion of the Earth
		return M + C + P + Constants.PI()
	}
	
	class func getSunCoords(d:Double) -> EquatorialCoordinates {
        let M:Double = SunUtils.getSolarMeanAnomaly(d:d)
        let L:Double = SunUtils.getEclipticLongitudeM(M:M)
		
        return EquatorialCoordinates(rightAscension: PositionUtils.getRightAscension(l: L, b: 0), declination: PositionUtils.getDeclination(l: L, b: 0))
	}
}
