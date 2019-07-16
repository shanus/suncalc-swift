//
//  suncalc.swift
//  suncalc
//
//  Created by Shaun Meredith on 10/2/14.
//
//

import Foundation

class SunCalc {
	let J0:Double = 0.0009
	
	var sunrise:Date
	var sunriseEnd:Date
	var goldenHourEnd:Date
	var solarNoon:Date
	var goldenHour:Date
	var sunsetStart:Date
	var sunset:Date
	var dusk:Date
	var nauticalDusk:Date
	var night:Date
	var nadir:Date
	var nightEnd:Date
	var nauticalDawn:Date
	var dawn:Date
	
	class func getSetJ(h:Double, phi:Double, dec:Double, lw:Double, n:Double, M:Double, L:Double) -> Double {
        let w:Double = TimeUtils.getHourAngle(h:h, phi: phi, d: dec)
        let a:Double = TimeUtils.getApproxTransit(ht: w, lw: lw, n: n)
		
        return TimeUtils.getSolarTransitJ(ds: a, M: M, L: L)
	}
	
	class func getTimes(date:Date, latitude:Double, longitude:Double) -> SunCalc {
		return SunCalc(date:date, latitude:latitude, longitude:longitude)
	}
	
	class func getSunPosition(timeAndDate:Date, latitude:Double, longitude:Double) -> SunPosition {
		let lw:Double = Constants.RAD() * -longitude
		let phi:Double = Constants.RAD() * latitude
        let d:Double = DateUtils.toDays(date: timeAndDate)
		
        let c:EquatorialCoordinates = SunUtils.getSunCoords(d: d)
        let H:Double = PositionUtils.getSiderealTime(d: d, lw: lw) - c.rightAscension
		
        return SunPosition(azimuth: PositionUtils.getAzimuth(h: H, phi: phi, dec: c.declination), altitude: PositionUtils.getAltitude(h: H, phi: phi, dec: c.declination))
	}
	
	class func getMoonPosition(timeAndDate:Date, latitude:Double, longitude:Double) -> MoonPosition {
		let lw:Double = Constants.RAD() * -longitude
		let phi:Double = Constants.RAD() * latitude
        let d:Double = DateUtils.toDays(date: timeAndDate)
		
        let c:GeocentricCoordinates = MoonUtils.getMoonCoords(d: d)
        let H:Double = PositionUtils.getSiderealTime(d: d, lw: lw) - c.rightAscension
        var h:Double = PositionUtils.getAltitude(h: H, phi: phi, dec: c.declination)
		
		// altitude correction for refraction
		h = h + Constants.RAD() * 0.017 / tan(h + Constants.RAD() * 10.26 / (h + Constants.RAD() * 5.10));
		
        return MoonPosition(azimuth: PositionUtils.getAzimuth(h: H, phi: phi, dec: c.declination), altitude: h, distance: c.distance)
	}
	
	class func getMoonIllumination(timeAndDate:Date) -> MoonIllumination {
        let d:Double = DateUtils.toDays(date: timeAndDate)
        let s:EquatorialCoordinates = SunUtils.getSunCoords(d: d)
        let m:GeocentricCoordinates = MoonUtils.getMoonCoords(d: d)
		
		let sdist:Double = 149598000; // distance from Earth to Sun in km
		
		let phi:Double = acos(sin(s.declination) * sin(m.declination) + cos(s.declination) * cos(m.declination) * cos(s.rightAscension - m.rightAscension))
		let inc:Double = atan2(sdist * sin(phi), m.distance - sdist * cos(phi))
		let angle:Double = atan2(cos(s.declination) * sin(s.rightAscension - m.rightAscension), sin(s.declination) * cos(m.declination) - cos(s.declination) * sin(m.declination) * cos(s.rightAscension - m.rightAscension))
		
		let fraction:Double = (1 + cos(inc)) / 2
		let phase:Double = 0.5 + 0.5 * inc * (angle < 0 ? -1 : 1) / Constants.PI()
		
		return MoonIllumination(fraction: fraction, phase: phase, angle: angle)
	}
    
    class func getMoonTimes(date:Date, latitude:Double, longitude:Double) -> MoonTimes {
        let hc:Double = 0.133 * Constants.RAD()
        var h0:Double = SunCalc.getMoonPosition(timeAndDate: date, latitude: latitude, longitude: longitude).altitude - hc
        var h1:Double = 0, h2:Double = 0, rise:Double = 0, set:Double = 0, a:Double = 0, b:Double = 0, xe:Double = 0, ye:Double = 0, d:Double = 0, roots:Double = 0, x1:Double = 0, x2:Double = 0, dx:Double = 0
        
        // go in 2-hour chunks, each time seeing if a 3-point quadratic curve crosses zero (which means rise or set)
        for i in stride(from: 1, through: 24, by: 2) {
            h1 = SunCalc.getMoonPosition(timeAndDate: DateUtils.getHoursLater(date: date, hours: Double(i))!, latitude: latitude, longitude: longitude).altitude - hc
            h2 = SunCalc.getMoonPosition(timeAndDate: DateUtils.getHoursLater(date: date, hours: Double(i + 1))!, latitude: latitude, longitude: longitude).altitude - hc
            a = (h0 + h2) / 2 - h1
            b = (h2 - h0) / 2
            xe = -b / (2 * a)
            ye = (a * xe + b) * xe + h1
            d = b * b - 4 * a * h1
            roots = 0
            
            if (d >= 0) {
                dx = sqrt(d) / (abs(a) * 2)
                x1 = xe - dx
                x2 = xe + dx
                if (abs(x1) <= 1) {
                    roots += 1
                }
                if (abs(x2) <= 1) {
                    roots += 1
                }
                if (x1 < -1) {
                    x1 = x2
                }
            }
            
            if (roots == 1) {
                if (h0 < 0) {
                    rise = Double(i) + x1
                } else {
                    set = Double(i) + x1
                }
            } else if (roots == 2) {
                rise = Double(i) + (ye < 0 ? x2 : x1)
                set = Double(i) + (ye < 0 ? x1 : x2)
            }
            
            if ((rise != 0) && (set != 0)) {
                break
            }
            h0 = h2
        }
        var result = [String:Any?]()
        result["alwaysUp"] = false
        result["alwaysDown"] = false
        if (rise != 0) {
            result["rise"] = DateUtils.getHoursLater(date: date, hours: rise)
        }
        if (set != 0) {
            result["set"] = DateUtils.getHoursLater(date: date, hours: set)
        }
        if ((rise == 0) && (set == 0)) {
            result[ye > 0 ? "alwaysUp" : "alwaysDown"] = true
        }
     
        return MoonTimes(rise: result["rise"] as? Date, set: result["set"] as? Date, alwaysUp: result["alwaysUp"] as! Bool, alwaysDown: result["alwaysDown"] as! Bool)
    }
    
	
	init(date:Date, latitude:Double, longitude:Double) {
		let lw:Double = Constants.RAD() * -longitude
		let phi:Double = Constants.RAD() * latitude
        let d:Double = DateUtils.toDays(date: date)
		
        let n:Double = TimeUtils.getJulianCycle(d: d, lw: lw)
        let ds:Double = TimeUtils.getApproxTransit(ht: 0, lw: lw, n: n)
		
        let M:Double = SunUtils.getSolarMeanAnomaly(d: ds)
        let L:Double = SunUtils.getEclipticLongitudeM(M: M)
        let dec:Double = PositionUtils.getDeclination(l: L, b: 0)
		
        let Jnoon:Double = TimeUtils.getSolarTransitJ(ds: ds, M: M, L: L)
		
        self.solarNoon = DateUtils.fromJulian(j: Jnoon)
        self.nadir = DateUtils.fromJulian(j: Jnoon - 0.5)
		
		// sun times configuration (angle, morning name, evening name)
		// unrolled the loop working on this data:
		// var times = [
		//             [-0.83, 'sunrise',       'sunset'      ],
		//             [ -0.3, 'sunriseEnd',    'sunsetStart' ],
		//             [   -6, 'dawn',          'dusk'        ],
		//             [  -12, 'nauticalDawn',  'nauticalDusk'],
		//             [  -18, 'nightEnd',      'night'       ],
		//             [    6, 'goldenHourEnd', 'goldenHour'  ]
		//             ];
		
		var h:Double = -0.83
        var Jset:Double = SunCalc.getSetJ(h: h * Constants.RAD(), phi: phi, dec: dec, lw: lw, n: n, M: M, L: L)
		var Jrise:Double = Jnoon - (Jset - Jnoon)
		
        self.sunrise = DateUtils.fromJulian(j: Jrise)
        self.sunset = DateUtils.fromJulian(j: Jset)
		
		h = -0.3;
        Jset = SunCalc.getSetJ(h: h * Constants.RAD(), phi: phi, dec: dec, lw: lw, n: n, M: M, L: L)
		Jrise = Jnoon - (Jset - Jnoon)
        self.sunriseEnd = DateUtils.fromJulian(j: Jrise)
        self.sunsetStart = DateUtils.fromJulian(j: Jset)
		
		h = -6;
        Jset = SunCalc.getSetJ(h: h * Constants.RAD(), phi: phi, dec: dec, lw: lw, n: n, M: M, L: L)
		Jrise = Jnoon - (Jset - Jnoon)
        self.dawn = DateUtils.fromJulian(j: Jrise)
        self.dusk = DateUtils.fromJulian(j: Jset)
		
		h = -12;
        Jset = SunCalc.getSetJ(h: h * Constants.RAD(), phi: phi, dec: dec, lw: lw, n: n, M: M, L: L)
		Jrise = Jnoon - (Jset - Jnoon)
        self.nauticalDawn = DateUtils.fromJulian(j: Jrise)
        self.nauticalDusk = DateUtils.fromJulian(j: Jset)
		
		h = -18;
        Jset = SunCalc.getSetJ(h: h * Constants.RAD(), phi: phi, dec: dec, lw: lw, n: n, M: M, L: L)
		Jrise = Jnoon - (Jset - Jnoon)
        self.nightEnd = DateUtils.fromJulian(j: Jrise)
        self.night = DateUtils.fromJulian(j: Jset)
		
		h = 6;
        Jset = SunCalc.getSetJ(h: h * Constants.RAD(), phi: phi, dec: dec, lw: lw, n: n, M: M, L: L)
		Jrise = Jnoon - (Jset - Jnoon)
        self.goldenHourEnd = DateUtils.fromJulian(j: Jrise)
        self.goldenHour = DateUtils.fromJulian(j: Jset)

	}
}
