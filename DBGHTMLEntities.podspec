Pod::Spec.new do |s|
  s.name             = "DBGHTMLEntities"
  s.version          = "0.1.0"
  s.summary          = "Easily Decode/Encode HTML entity strings (e.g. &amp;)"
  s.description      = <<-DESC
                       Easily Decode/Encode HTML entity strings (e.g. &amp;). Tested, and with a sexy LICENSE.

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/dbgrandi/DBGHTMLEntities"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "David Grandinetti" => "dave@wegoto12.com" }
  s.source           = { :git => "https://github.com/dbgrandi/DBGHTMLEntities.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dbgrandi'

  s.platform     = :ios, '5.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
