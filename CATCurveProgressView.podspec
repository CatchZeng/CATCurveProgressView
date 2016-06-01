Pod::Spec.new do |s|
    s.name         = "CATCurveProgressView"
    s.version      = "1.0.1"
    s.license      = 'MIT'
    s.homepage     = "http://catchzeng.com"
    s.summary      = "iOS custom  curve (circular、arc、circle) progress view, supports gradient color, any angle, IBDesignable & IBInspectable, etc.."
    s.author		 = { "CatchZeng" => "891793848@qq.com" }
    s.platform     = :ios, '7.0'
    s.source       = { :git => "https://github.com/CatchZeng/CATCurveProgressView.git", :tag => "1.0.1" }
    s.source_files  = "CATCurveProgressView/CATCurveProgressView/CATCurveProgressView.{h,m}"
    s.requires_arc = true
end