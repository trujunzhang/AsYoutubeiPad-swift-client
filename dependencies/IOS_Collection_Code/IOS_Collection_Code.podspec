
Pod::Spec.new do |s|
  s.name     = 'IOS_Collection_Code'
  s.version  = '0.1.0'
  s.license  = 'MIT'
  s.summary  = 'IOS_Collection_Code aims to be a drop-in replacement for UITabBarController.' 
  s.description = 'IOS_Collection_Code aims to be a drop-in replacement of UITabBarController with the intention of letting developers easily customise its appearance. JBTabBar uses .'
  s.homepage = 'http://www.github.com/wanghaogithub720'
  s.author   = { 'Jin Budelmann' => 'jin@bitcrank.com' }
  s.source   = { :git => 'https://github.com/wanghaogithub720/mxYoutube.git', :tag => '0.1.0' }
  s.platform = :ios, '7.0'

  #s.source_files = 'Pod/Classes/*/*.{h,m}'
  #s.resources = "Pod/Assets/IOS_Collection_Code.bundle"

  s.requires_arc = true

  s.subspec 'CacheImage' do |sub|
    sub.source_files = 'Pod/Classes/CacheImage/*.{h,m}'
  end

  s.subspec 'debug' do |sub|
    sub.source_files = 'Pod/Classes/debug/*.{h,m}'
  end

  s.subspec 'resolutions' do |sub|
    sub.source_files = 'Pod/Classes/resolutions/*.{h,m}'
  end

  s.subspec 'xibViews' do |sub|
    sub.source_files = 'Pod/Classes/xibViews/*.{h,m}'
  end

  s.subspec 'effect' do |sub|
    sub.source_files = 'Pod/Classes/effect/*.{h,m}'
  end

  s.subspec 'UIView-Shadow-Maker' do |sub|
    sub.source_files = 'Pod/Classes/UIView-Shadow-Maker/*.{h,m}'
  end

  s.subspec 'JMWhenTapped' do |sub|
    sub.source_files = 'Pod/Classes/JMWhenTapped/*.{h,m}'
  end

  s.subspec 'UIView-UIImageEffects' do |sub|
    sub.source_files = 'Pod/Classes/UIView-UIImageEffects/*.{h,m}'
  end

  s.subspec 'UIColor-Colors' do |sub|
    sub.source_files = 'Pod/Classes/UIColor-Colors/*.{h,m}'
  end

  s.subspec 'UIColor-Colors' do |sub|
    sub.source_files = 'Pod/Classes/UIColor-Colors/*.{h,m}'
  end

  s.subspec 'AsyncDisplayKitCatelog' do |sub|
    sub.source_files = 'Pod/Classes/AsyncDisplayKitCatelog/*.{h,m}'
  end

  s.subspec 'uikit-Category' do |sub|
    sub.source_files = 'Pod/Classes/uikit-Category/*.{h,m}'
  end


end

