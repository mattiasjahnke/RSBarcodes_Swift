Pod::Spec.new do |s|
  s.name         = "RSBarcodes_Swift"
  s.version      = "0.0.8"
  s.summary      = "1D and 2D barcodes reader and generators for iOS 8 with delightful controls. Now Swift. "
  s.homepage     = "https://github.com/yeahdongcn/RSBarcodes_Swift"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       = { "R0CKSTAR" => "yeahdongcn@gmail.com" }
  s.platform     = :ios, '8.0'
  s.source_files = 'Source/*.swift'
  s.frameworks   = ['CoreImage', 'AVFoundation', 'QuartzCore']
  s.requires_arc = true
end
