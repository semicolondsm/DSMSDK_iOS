#
#  Be sure to run `pod spec lint DSMSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "DSMSDK"
  spec.version      = "1.2.0"
  spec.summary      = "SDK for DSM_Auth"
  spec.description  = <<-DESC
    "A SDK for easy use DSM_Auth with Swift"
                   DESC

  spec.homepage     = "http://193.123.237.232"

  spec.license      = "MIT"
  
  spec.author             = { "kimxwan0319" => "kimxwan0319@naver.com" }

  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/semicolonDSM/DSMSDK_iOS.git", :tag => "1.2.0"}

  spec.source_files  = "DSMSDK/Classes/**/*"

  spec.frameworks = "Foundation", "UIKit", "WebKit"
  spec.dependency "Alamofire", "~> 5.2"
  
  spec.swift_version = "5.0"

end
