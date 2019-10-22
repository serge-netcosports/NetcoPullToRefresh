Pod::Spec.new do |s|
  s.name             = 'Oculis'
  s.version          = '0.1.0'
  s.summary          = 'Oculis is a set of Netco services'

  s.homepage         = 'https://github.com/netcosports/Oculis'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'serge-netcosports' => 'sergei.krumin@netcosports.com' }
  s.source           = { :git => 'https://github.com/netcosports/Oculis.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.default_subspec = 'Default'
  s.static_framework = true

  s.subspec 'Default' do |ss|
  	ss.dependency 'Oculis/Core'
  end

  s.subspec 'Core' do |ss|
  	ss.source_files = 'Sources/ConfigService/*.swift'
  end

  s.subspec 'AnalyticsServices' do |ss|
  	ss.source_files = 'Sources/AnalyticsServices/*.swift'
  	ss.dependency 'Firebase/Analytics'
    ss.dependency 'Oculis/Core'
  end
  
  s.dependency 'Astrarium'
  s.dependency 'Gnomon'
end
