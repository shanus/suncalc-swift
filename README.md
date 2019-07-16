suncalc-swift
=============

This is a swift port for iOS of https://github.com/mourner/suncalc

This code is based on the original Javascript suncalc by Vladimir Agafonkin ("mourner").

```swift
// get today's sunlight times for London

let date:Date = Date()
let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: 51.5, longitude: -0.1)

var formatter:DateFormatter = DateFormatter()
formatter.dateFormat = "HH:mm"
formatter.timeZone = TimeZone(abbreviation: "GMT")
var sunriseString:String = formatter.string(from: sunCalc.sunrise)
println("sunrise is at \(sunriseString)")

let sunPos:SunPosition = SunCalc.getSunPosition(date, latitude: 51.5, longitude: -0.1)

var sunriseAzimuth:Double = sunPos.azimuth * 180 / Constants.PI()
println("sunrise azimuth: \(sunriseAzimuth)")
```
