Pod::Spec.new do |s|
   s.name     = 'PEARHttpFetcher'
   s.version  = '0.0.1'
   s.platform = :'ios', '7.0'
   s.license  = 'MIT'
   s.summary  = 'Http fetcher Library'
   s.homepage = 'https://github.com/HirokiUmatani'
   s.author   = { "HirokiUmatani" => "o9093009555@gmail.com" }
   s.source   = { :git => 'https://github.com/HirokiUmatani/PEARHttpFetcher.git', :tag => s.version.to_s }
   s.source_files = 'PEARHttpFetcher/*.{h,m}'
   s.requires_arc = true
end
