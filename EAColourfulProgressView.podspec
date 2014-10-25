Pod::Spec.new do |s|
  s.name             = "EAColourfulProgressView"
  s.version          = "0.1.0"
  s.summary          = "A simple Progress View that allows colour changing via Interface Builder"
  s.description      = <<-DESC
                       A progress view that generates a colour within two colours, depending on its
                       its current value. All the values are customizable within Interface Builder,
                       through the usage of IBInspectable, and the custom view can be seen with 
                       live rendering via IBDesignable.
                       DESC
  s.homepage         = "https://github.com/Eddpt/EAColourfulProgressView"
  s.license          = 'MIT'
  s.author           = { "Edgar Antunes" => "Eddpt@users.noreply.github.com" }
  s.source           = { :git => "https://github.com/Eddpt/EAColourfulProgressView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'EAColourfulProgressView/*.{h,m}'
  s.frameworks = 'UIKit'
end
