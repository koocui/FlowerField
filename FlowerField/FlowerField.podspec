Pod::Spec.new do |s|
  s.name         = 'FlowerField'
  s.version      = '<#Project Version#>'
  s.license      = '<#License#>'
  s.homepage     = '<#Homepage URL#>'
  s.authors      = '<#Author Name#>': '<#Author Email#>'
  s.summary      = '<#Summary (Up to 140 characters#>'

  s.platform     =  :ios, '<#iOS Platform#>'
  s.source       =  git: '<#Github Repo URL#>', :tag => s.version
  s.source_files = '<#Resources#>'
  s.frameworks   =  '<#Required Frameworks#>'
  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod "FlowerField"
  s.dependencies =	pod 'SnapKit', '~> 0.20.0' ## 自动布局
  s.dependencies =	pod 'Alamofire', '~> 3.3.1' ## 网络请求, swift版的AFN
  s.dependencies =	pod 'Kingfisher', '~> 2.3.1' ## 轻量级的SDWebImage

end