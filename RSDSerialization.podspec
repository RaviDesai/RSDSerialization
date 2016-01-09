#
# Be sure to run `pod lib lint RSDSerialization.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RSDSerialization"
  s.version          = "0.3.5"
  s.summary          = "JSON Serialization helpers written in swift"
  s.description      = <<-DESC
                        Methods to aid in JSON serialization/deserialization for STRUCT types in Swift.
                        Of course these methods can also be used for CLASS types, but since CLASS types can support dynamic (objective-c) style reflection, there are probably better alternatives.
                        DESC
  s.homepage         = "https://github.com/RaviDesai/RSDSerialization"
  s.license          = 'MIT'
  s.author           = { "RaviDesai" => "ravidesai@me.com" }
  s.source           = { :git => "https://github.com/RaviDesai/RSDSerialization.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Ravi_S_Desai'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'Foundation'
end
