Pod::Spec.new do |s|
  s.name                    = 'DSDMenu'
  s.version                 = '0.2.6'
  s.summary                 = 'A dead-simpe, UIkit-based dropdown menu, written in Swift'
  s.description = <<-DESC
                     This pod allows you to use subclass of the UIButton UIKit class, DropDownMenu, to create beautiful and customizable drop-down menus.
                   DESC
  s.homepage                = 'https://github.com/m3g0byt3/DSDMenu'
  s.screenshots             = [ 'https://raw.githubusercontent.com/m3g0byt3/DSDMenu/master/Images/screenshot01.png',
                                'https://raw.githubusercontent.com/m3g0byt3/DSDMenu/master/Images/screenshot02.png' ]
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'm3g0byt3' => 'm3g0byt3@gmail.com' }
  s.source                  = { :git => 'https://github.com/m3g0byt3/DSDMenu.git', :tag => s.version.to_s }
  s.platform                = :ios
  s.ios.deployment_target   = '9.0'
  s.swift_version           = '4.0'
  s.source_files            = 'Source/**/*'
  s.frameworks              = 'UIKit'

end
