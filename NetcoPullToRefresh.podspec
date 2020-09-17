Pod::Spec.new do |s|
  s.name             = 'NetcoPullToRefresh'
  s.version          = '0.1.1'
  s.summary          = 'NetcoPullToRefresh is a custom Netco pull to refresh for iOS'

  s.homepage         = 'https://github.com/serge-netcosports/NetcoPullToRefresh'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'serge-netcosports' => 'sergei.krumin@netcosports.com' }
  s.source           = { :git => 'https://github.com/serge-netcosports/NetcoPullToRefresh.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = "Sources/*.swift"

  s.static_framework = true

  s.dependency 'RxSwift', '~> 5'
  s.dependency 'RxCocoa', '~> 5'
  s.dependency 'NVActivityIndicatorView', '~> 4.8.0'
end
