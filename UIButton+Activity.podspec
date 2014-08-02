Pod::Spec.new do |s|
  s.name             = "UIButton+Activity"
  s.version          = "1.0.0"
  s.summary          = "UIButton that displays an activity indicator when disabled."
  s.homepage         = "https://github.com/needbee/uibutton-activity"
  s.license          = 'MIT'
  s.author           = { "Josh Justice" => "josh@need-bee.com" }
  s.source           = { :git => "https://github.com/needbee/uibutton-activity.git", :tag => s.version.to_s }
  s.platform         = :ios, '6.0'
  s.requires_arc     = true
  s.source_files     = 'src', 'src/**/*.{h,m}'
end
