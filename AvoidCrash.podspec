Pod::Spec.new do |s|
s.name         = "AvoidCrash"
s.platform = :ios, "7.0"
s.version      = "1.5.0"
s.ios.deployment_target = '7.0'
s.summary      = "This framework can avoid Foundation framework potential crash danger"
s.homepage     = "https://github.com/chenfanfang/AvoidCrash"
s.license      = "MIT"
s.author             = { "陈蕃坊" => "493336001@qq.com" }
s.social_media_url   = "http://www.jianshu.com/users/80fadb71940d/latest_articles"
s.source       = { :git => "https://github.com/chenfanfang/AvoidCrash.git", :tag => s.version }
s.source_files  = "AvoidCrash"
s.requires_arc = true


non_arc_files = 'NSMutableArray+AvoidCrash.m'

s.subspec 'no-arc' do |sp|
sp.source_files = non_arc_files
sp.requires_arc = false

end

end
