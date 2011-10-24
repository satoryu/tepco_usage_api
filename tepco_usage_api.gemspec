require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'tepco_usage_api'
  spec.required_ruby_version = '>= 1.8.7'
  spec.summary = 'The gem to talk with Tepco Usage API. '
  spec.version = '0.3.0'
  spec.license = 'MIT'
  spec.author  = 'Tatsuya Sato'
  spec.email   = 'satoryu.1981@gmail.com'
  spec.homepage = 'http://github.com/satoryu/tepco_usage_api/'
  spec.description = <<-"DESC"
This gem provides tepco-usage-api wrapper class. 
The wrapper class allows us to easily get the power usage information provided by TEPCO. 
  DESC
  spec.files = FileList[%w[
    [A-Z]*
    lib/**/*.rb
    spec/**/*
  ]]
  spec.add_dependency('nokogiri', '>= 1.4.0')
  spec.add_development_dependency('rspec')
end

