
Pod::Spec.new do |s|

s.name         = "JHSheetActionView"
s.version      = "1.0.1"
s.ios.deployment_target = '8.0'
s.summary      = "It is an imitation WeChat controls can quick import project engineering"
s.homepage     = "https://github.com/jianghao562/JHSheetViewCustom"
s.license      = "MIT"
s.author             = { "JiangHao" => "122151265@qq.com" }
s.source       = { :git => "https://github.com/jianghao562/JHSheetViewCustom.git", :tag => s.version }
s.source_files  = "JHSheetActionView"
s.requires_arc = true
s.dependency 'Masonry'
end
