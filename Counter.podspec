Pod::Spec.new do |s|
  s.name             = 'Counter'
  s.version          = '1.1'
  s.summary          = 'Powerful and multipurpose counter'

  s.description      = <<-DESC
Powerful and multipurpose counter:
- Easy to use
- Increment/Decrement
- You decide the start value
- Sum several values in a single call
- Use your own objects
- Set Milestones (alarms)
- Automatic counter
                       DESC

  s.homepage         = 'https://github.com/Juanpe/Counter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Juanpe Catalán' => 'juanpecm@gmail.com' }
  s.source           = { :git => 'https://github.com/Juanpe/Counter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/juanpeCMiOS'

  s.ios.deployment_target = '9.0'
  s.source_files = 'Counter/Classes/**/*'


end
