
Pod::Spec.new do |spec|

  spec.name         = "UUKit"
  spec.version      = "0.0.4"
  spec.platform     = :ios, "10.0"
  spec.summary      = "iOS开发基础组件"
  spec.description  = "iOS开发基础组件，包括一些有用的扩展，等工具."
  spec.homepage     = "https://github.com/UUKit/UUKit"
  
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = { "UUKit" => "uukit@uxiu.me , mail@uxiu.me" }
  spec.source                = { :git => 'https://github.com/UUKit/UUKit.git', :tag => spec.version.to_s }
  spec.ios.deployment_target = "10.0"



  spec.source_files          = 'UUKit/Classes/**/*'


  # spec.swift_version = '5.0'
  # spec.public_header_files = "Classes/**/*.h"
  
  
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
