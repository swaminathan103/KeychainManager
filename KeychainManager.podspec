Pod::Spec.new do |spec|

  spec.name         = "KeychainManager"
  spec.version      = "1.0"
  spec.summary      = "A Swift wrapper for basic generic password keychain queries for iOS apps."

  spec.description  = <<-DESC
            A Swift wrapper for basic generic password keychain queries for iOS apps. It can be customised with service and accessGroup. It can be used for storing and retrieving Generic password in keychain
                   DESC

  spec.homepage     = "https://github.com/swaminathan103/KeychainManager"


  spec.license      = "MIT"

  spec.author             = { "Swaminathan" => "swaminathan103@gmail.com" }
  spec.social_media_url   = "https://twitter.com/kaatupoochi103"
  
  spec.platform     = :ios
  spec.ios.deployment_target = '9.0'

  spec.source       = { :git => "https://github.com/swaminathan103/KeychainManager.git", :tag => spec.version }

  spec.source_files  = "KeychainManager/**/*.{h,swift}"
  
  spec.swift_version = ['4.2', '5.0']

end
