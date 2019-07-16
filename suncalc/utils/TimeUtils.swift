//
//  TimeUtils.swift
//  suncalc-example
//
//  Created by Shaun Meredith on 10/2/14.
//

import Foundation

let J0:Double = 0.0009

class TimeUtils {
	
	class func getJulianCycle(d:Double, lw:Double) -> Double {
		return round(d - J0 - lw / (2 * Constants.PI()))
	}
	
	class func getApproxTransit(ht:Double, lw:Double, n:Double) -> Double {
		return J0 + (ht + lw) / (2 * Constants.PI()) + n
	}
	
	class func getSolarTransitJ(ds:Double, M:Double, L:Double) -> Double {
		return J2000 + ds + 0.0053 * sin(M) - 0.0069 * sin(2 * L)
	}
	
	class func getHourAngle(h:Double, phi:Double, d:Double) -> Double {
		return acos((sin(h) - sin(phi) * sin(d)) / (cos(phi) * cos(d)))
	}
    
    class func getSetJ(h:Double, lw:Double, phi:Double, dec:Double, n:Double, M:Double, L:Double) -> Double {
        let w:Double = TimeUtils.getHourAngle(h: h, phi: phi, d: dec)
        let a:Double = TimeUtils.getApproxTransit(ht: w, lw: lw, n: n  )
        return TimeUtils.getSolarTransitJ(ds: a, M: M, L: L)
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getJulianCycle instead.")
    class func getJulianCycleD(d:Double, lw:Double) -> Double {
        return TimeUtils.getJulianCycle(d: d, lw: lw)
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getApproxTransit instead.")
    class func getApproxTransitHt(ht:Double, lw:Double, n:Double) -> Double {
        return TimeUtils.getApproxTransit(ht: ht, lw: lw, n: n)
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getSolarTransitJ instead.")
    class func getSolarTransitJDs(ds:Double, M:Double, L:Double) -> Double {
        return TimeUtils.getSolarTransitJ(ds: ds, M: M, L: L)
    }
    
    @available(*, deprecated: 1.0, message: "will soon become unavailable. Use getHourAngle instead.")
    class func getHourAngleH(h:Double, phi:Double, d:Double) -> Double {
        return TimeUtils.getHourAngle(h: h, phi: phi, d: d)
    }
}
