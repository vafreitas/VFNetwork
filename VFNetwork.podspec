#
# Be sure to run `pod lib lint VFNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'VFNetwork'
    s.version          = '1.4.3'
    s.summary          = 'The Swift Network Protocol Oriented Framework.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    VFNetwork is a protocol-oriented framework that will help you assemble your network layer quickly with just a few steps
    DESC
    
    s.homepage         = 'https://github.com/vafreitas/VFNetwork'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Victor Freitas' => 'vitoralves59@gmail.com' }
    
    s.ios.deployment_target = '12.0'
    s.swift_version = "5.5"

    s.source           = { :git => 'https://github.com/vafreitas/VFNetwork.git', :tag => "#{s.version}" }
    s.source_files = "Sources/VFNetwork/**/*.{swift,h,m}"
end
