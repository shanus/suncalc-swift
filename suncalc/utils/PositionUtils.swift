//
//  PositionUtils.swift
//  suncalc-example
//
//  Created by Shaun Meredith on 10/2/14.
//

import Foundation

class PositionUtils {
	
	class func getRightAscension(l:Double, b:Double) -> Double {
		return atan2(sin(l) * cos(Constants.E()) - tan(b) * sin(Constants.E()), cos(l))
	}
	
	class func getDeclination(l:Double, b:Double) -> Double {
		return asin(sin(b) * cos(Constants.E()) + cos(b) * sin(Constants.E()) * sin(l))
	}
	
	class func getAzimuth(h:Double, phi:Double, dec:Double) -> Double {
		return atan2(sin(h), cos(h) * sin(phi) - tan(dec) * cos(phi))
	}
	
	class func getAltitude(h:Double, phi:Double, dec:Double) -> Double {
		 return asin(sin(phi) * sin(dec) + cos(phi) * cos(dec) * cos(h))
	}
	
	class func getSiderealTime(d:Double, lw:Double) -> Double {
		return Constants.RAD() * (280.16 + 360.9856235 * d) - lw
	}
    
    class func getAstroRefraction(h:Double) -> Double {
        var hCalc:Double = h
        if (hCalc < 0) {
            hCalc = 0;
        }
        return 0.0002967 / tan(hCalc + 0.00312536 / (hCalc + 0.08901179));
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getRightAscension instead.")
    class func getRightAscensionL(l:Double, b:Double) -> Double {
        return PositionUtils.getRightAscension(l: l, b: b)
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getDeclination instead.")
    class func getDeclinationL(l:Double, b:Double) -> Double {
        return PositionUtils.getDeclination(l: l, b: b)
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getAzimuth instead.")
    class func getAzimuthH(h:Double, phi:Double, dec:Double) -> Double {
        return PositionUtils.getAzimuth(h: h, phi: phi, dec: dec)
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getAltitude instead.")
    class func getAltitudeH(h:Double, phi:Double, dec:Double) -> Double {
        return PositionUtils.getAltitude(h: h, phi: phi, dec: dec)
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getSiderealTime instead.")
    class func getSiderealTimeD(d:Double, lw:Double) -> Double {
        return PositionUtils.getSiderealTime(d: d, lw: lw)
    }

}
