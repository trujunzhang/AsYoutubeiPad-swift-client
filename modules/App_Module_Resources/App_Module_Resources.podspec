#
# Be sure to run `pod lib lint App_Module_Resources.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "App_Module_Resources"
  s.version          = "0.1.0"
  s.summary          = "A short description of App_Module_Resources."
  s.description      = <<-DESC
                       An optional longer description of App_Module_Resources

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/App_Module_Resources"
  s.license          = 'MIT'
  s.author           = { "wanghaogithub720" => "wanghaomspace@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/App_Module_Resources.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.resource = "Pod/Assets/*/*.*"

  s.subspec 'UnitTestResource' do |sub|
    sub.resource = 'Pod/Assets/UnitTestResource/*/*.*'
  end  

  s.subspec 'watch_tabbar' do |sub|
    sub.resource = 'Pod/Assets/bars/*/*.*'
  end    

  #s.subspec 'CacheImage' do |sub|
  #  sub.source_files = 'Pod/Classes/CacheImage/*.{h,m}'
  #end

  s.subspec 'ImageEffects' do |sub|
    sub.source_files = 'Pod/Classes/ImageEffects/*.{h,m}'
  end

  s.subspec 'STCollapseTableView' do |sub|
    sub.source_files = 'Pod/Classes/STCollapseTableView/*.{h,m}'
  end  

  s.subspec 'SWRevealViewController' do |sub|
    sub.source_files = 'Pod/Classes/SWRevealViewController/*.{h,m}'
  end        

  s.subspec 'RDVTabBarController' do |sub|
    sub.source_files = 'Pod/Classes/RDVTabBarController/*.{h,m}'
  end 

  s.subspec 'YoutubeParser' do |sub|
    sub.source_files = 'Pod/Classes/YoutubeParser/*.{h,m}'
  end     

  s.subspec 'Subtitles' do |sub|
    sub.source_files = 'Pod/Classes/Subtitles/*/*.{h,m}'
  end      
  
end
