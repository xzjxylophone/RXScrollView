




Pod::Spec.new do |s|
  s.name     = "RXScrollView"
  s.version  = "0.4"
  s.license  = "MIT"
  s.summary  = "RXScrollView is a simple limit/infinite scrollView"
  s.homepage = "https://github.com/xzjxylophone/RXScrollView"
  s.author   = { 'Rush.D.Xzj' => 'xzjxylophoe@gmail.com' }
  s.social_media_url = "http://weibo.com/xzjxylophone"
  s.source   = { :git => 'https://github.com/xzjxylophone/RXScrollView.git', :tag => "v#{s.version}" }
  s.description = %{
    RXScrollView is a simple limit/infinite scrollView.
  }
  s.source_files = 'RXScrollView/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.platform = :ios, '6.0'
end


















