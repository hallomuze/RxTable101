# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'



target 'RxTable101' do

use_frameworks!

pod 'RxSwift', '~> 3.6'
pod 'RxCocoa', '~> 3.6'

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
   target.build_configurations.each do |config|
     config.build_settings['SWIFT_VERSION'] = '3.1'
   end
 end
end
