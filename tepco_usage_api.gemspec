require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'tepco_usage_api'
  spec.required_ruby_version = '>= 1.8.7'
  spec.summary = 'The gem to talk with Yahoo! Web API. '
  spec.version = '0.1.0'
  spec.author  = 'Tatsuya Sato'
  spec.email   = 'satoryu.1981@gmail.com'
  spec.homepage = 'http://github.com/satoryu/tepco_usage_api/'
  spec.files = FileList[%w[
    [A-Z]*
    lib/**/*.rb
    spec/**/*
  ]]
end

