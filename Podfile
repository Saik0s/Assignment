using_bundler = defined? Bundler
unless using_bundler
  puts "\nPlease re-run using:".red
  puts "  bundle exec pod install\n\n"
  exit(1)
end

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'Assignment' do
  use_frameworks!

  # Pods for Assignment
  # ReactiveX
  pod 'RxSwift' #, git: 'https://github.com/ReactiveX/RxSwift.git'
  pod 'RxCocoa' #, git: 'https://github.com/ReactiveX/RxSwift.git'
  #pod 'RxBlocking' #, git: 'https://github.com/ReactiveX/RxSwift.git'
  #pod 'RxTest' #, git: 'https://github.com/ReactiveX/RxSwift.git'
  pod 'RxSwiftExt/RxCocoa' #, git: 'https://github.com/RxSwiftCommunity/RxSwiftExt.git'
  pod 'RxOptional' #, git: 'https://github.com/RxSwiftCommunity/RxOptional.git'
  pod 'Action' #, git: 'https://github.com/RxSwiftCommunity/Action.git'
  pod 'NSObject+Rx' #, git: 'https://github.com/RxSwiftCommunity/NSObject-Rx.git'
  # pod 'RxNimble' #, git: 'https://github.com/RxSwiftCommunity/RxNimble.git'

  # UI
  pod 'Texture/IGListKit' #, git: 'https://github.com/texturegroup/texture.git'
  pod 'lottie-ios' #, git: 'https://github.com/airbnb/lottie-ios.git'

  # Network
  pod 'MoyaSugar/RxSwift' #, git: 'https://github.com/devxoul/MoyaSugar.git'

  target 'AssignmentTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AssignmentUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
