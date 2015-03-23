Pod::Spec.new do |s|

  s.name         = "MKHGenericHelpers"
  s.version      = "1.0.0"
  s.summary      = "Set of generic helpers for iOS SDK"
  s.homepage     = "https://github.com/maximkhatskevich/MKHGenericHelpers"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Maxim Khatskevich" => "maxim.khatskevich@gmail.com" }
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/maximkhatskevich/MKHGenericHelpers.git", :tag => "#{s.version}" }

  s.requires_arc = true

  s.source_files  = "Src/*.{h,m}"

end
