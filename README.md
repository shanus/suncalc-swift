suncalc-swift
=============

This is a swift port for iOS of https://github.com/mourner/suncalc

This code is based on the original Javascript suncalc by Vladimir Agafonkin ("mourner").

```swift
// get today's sunlight times for London

let date:NSDate = NSDate()
let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: 51.5, longitude: -0.1)

var formatter:NSDateFormatter = NSDateFormatter()
formatter.dateFormat = "HH:mm"
formatter.timeZone = NSTimeZone(abbreviation: "GMT")
var sunriseString:String = formatter.stringFromDate(sunCalc.sunrise)
println("sunrise is at \(sunriseString)")

let sunPos:SunPosition = SunCalc.getSunPosition(date, latitude: 51.5, longitude: -0.1)

var sunriseAzimuth:Double = sunPos.azimuth * 180 / Constants.PI()
println("sunrise azimuth: \(sunriseAzimuth)")
```