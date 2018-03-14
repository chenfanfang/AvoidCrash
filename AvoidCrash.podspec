Pod::Spec.new do |s|
s.name         = "AvoidCrash"
s.platform = :ios, "7.0"
s.version      = "2.5.2"
s.ios.deployment_target = '7.0'
s.summary      = "This framework can avoid Foundation framework potential crash danger"
s.homepage     = "https://github.com/chenfanfang/AvoidCrash"
s.license      = "MIT"
s.author             = { "陈蕃坊" => "493336001@qq.com" }
s.social_media_url   = "http://www.jianshu.com/users/80fadb71940d/latest_articles"
s.source       = { :git => "https://github.com/chenfanfang/AvoidCrash.git", :tag => s.version }

s.source_files  = 'AvoidCrash/**/*.{h,m}'
s.requires_arc = [
                  'AvoidCrash/AvoidCrash.m',
                  'AvoidCrash/AvoidCrashStubProxy.m',
                  'AvoidCrash/NSObject+AvoidCrash.m',
                  'AvoidCrash/NSArray+AvoidCrash.m',
                  'AvoidCrash/NSDictionary+AvoidCrash.m',
                  'AvoidCrash/NSMutableDictionary+AvoidCrash.m',
                  'AvoidCrash/NSString+AvoidCrash.m',
                  'AvoidCrash/NSMutableString+AvoidCrash.m',
                  'AvoidCrash/NSAttributedString+AvoidCrash.m',
                  'AvoidCrash/NSMutableAttributedString+AvoidCrash.m']


end


