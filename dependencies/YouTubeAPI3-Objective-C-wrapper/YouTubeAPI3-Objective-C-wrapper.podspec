
Pod::Spec.new do |s|
  s.name     = 'YouTubeAPI3-Objective-C-wrapper'
  s.version  = '0.1.0'
  s.license  = 'MIT'
  s.summary  = 'A simple wrapper for YouTube data API 3.0 written completely in Objective-C'
  s.description = 'A simple Objective-C wrapper for most of YouTube API v3.0 functions (including OAuth2.0 implementation). Designed to make it simple to integrate YouTube functionality within your iOS app.'
  s.homepage = 'https://github.com/muhammadbassio'
  s.author   = { 'muhammadbassio' => 'jin@bitcrank.com' }
  s.source   = { :git => 'https://github.com/muhammadbassio/YouTubeAPI3-Objective-C-wrapper', :tag => '0.1.0' }
  s.platform = :ios, '7.0'

  s.requires_arc = true

  s.subspec 'API' do |sub|
    sub.source_files = 'Pod/Classes/API/*/*/*.{h,m}','Pod/Classes/API/*/*.{h,m}'
  end

  s.subspec 'OAuthFrameWork' do |sub|
    sub.source_files = 'Pod/Classes/OAuthFrameWork/*.{h,m}'
  end

  s.subspec 'Tools' do |sub|
    sub.source_files = 'Pod/Classes/Tools/*.{h,m}'
  end

  s.subspec 'TranscriptToSRT' do |sub|
    sub.source_files = 'Pod/Classes/TranscriptToSRT/*.{h,m}','Pod/Classes/TranscriptToSRT/MWFeedParser/*.{h,m}'
  end

  #s.subspec 'VideoInfoMetadata' do |sub|
  #  sub.source_files = 'Pod/Classes/VideoInfoMetadata/*.{h,m}'
  #end

  s.subspec 'YoutubeVideo-Extends' do |sub|
    sub.source_files = 'Pod/Classes/YoutubeVideo-Extends/*.{h,m}'
  end

  s.subspec 'Youtube-Sources' do |sub|
    sub.source_files = 'Pod/Classes/Youtube-Sources/*.h'
  end

  s.subspec 'MAB_Sources' do |sub|
    sub.source_files = 'Pod/Classes/MAB_Sources/*.{h,m}'
  end

  s.subspec 'YoutubeAuthor' do |sub|
    sub.source_files = 'Pod/Classes/YoutubeAuthor/*.{h,m}'
  end




end
