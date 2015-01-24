Pod::Spec.new do |s|
	s.name        = "suncalc-swift"
	s.version     = "0.1.2"
	s.summary     = "This is a swift port for iOS of https://github.com/mourner/suncalc"
	s.homepage    = "https://github.com/shanus/suncalc-swift"
	s.license     = { :type => "MIT" }
	s.authors     = { "shanus" => "shaun@chimani.com" }

	s.requires_arc = true
	s.platform = :ios
	s.ios.deployment_target = "8.0"
	s.source   = { :git => "https://github.com/shanus/suncalc-swift.git", :tag => "0.1.2"}
	s.source_files = "suncalc/**/*.swift"
end