

Pod::Spec.new do |spec|
  spec.name         = "SwiftTools"
  spec.version      = "1.0.3"
  spec.summary      = "SwiftTools 项目常用的工具库"
  spec.description  = <<-DESC
  swift 项目常用工具库
                   DESC

  spec.homepage     = "http://lerpo.github.io"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "xml" => "" }
  spec.platform     = :ios
  spec.ios.deployment_target = "10.0"
  spec.source       = { :git => "http://127.0.0.1:8088/xml/tools.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{swift}"
  spec.exclude_files = "Classes/Exclude"

  spec.dependency 'HandyJSON', '~> 5.0.1'
  spec.dependency 'SwiftyJSON'
  spec.dependency 'Alamofire', '~> 5.1'
  spec.dependency 'MJRefresh'
  spec.dependency 'MBProgressHUD', '~> 1.2.0'

end
