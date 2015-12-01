Pod::Spec.new do |s|
	s.name        = "suncalc-swift"
	s.module_name = "SunCalc"
	s.version     = "0.2.1"
	s.summary     = "This is a swift 2 port for iOS of https://github.com/mourner/suncalc"
	s.homepage    = "https://github.com/shanus/suncalc-swift"
	s.license     = { :type => "MIT" }
	s.authors     = { "shanus" => "shaun@chimani.com" }

	s.requires_arc = true
	s.platform = :ios
	s.ios.deployment_target = "8.0"
	s.source   = { :git => "https://github.com/shanus/suncalc-swift.git", :tag => "0.2.1"}
	s.source_files = "suncalc/**/*.swift"
end