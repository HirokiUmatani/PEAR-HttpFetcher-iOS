Pod::Spec.new do |s|
   s.name     = 'PEAR-HttpFetcher-iOS'
   s.version  = '0.0.3'
   s.platform = :'ios', '7.0'
   s.license  = 'MIT'
   s.summary  = 'http fetcher Library'
   s.homepage = 'https://github.com/HirokiUmatani'
   s.author   = { "HirokiUmatani" => "o9093009555@gmail.com" }
   s.source   = { :git => 'https://github.com/HirokiUmatani/PEAR-HttpFetcher-iOS.git', :tag => s.version.to_s }
   s.source_files = 'PEAR-HttpFetcher-iOS/*.{h,m}'
   s.requires_arc = true
end
