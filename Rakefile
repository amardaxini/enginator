require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('enginator', '0.1.1') do |p|
  p.project        = "enginator"
  p.description    = "A collection of useful generator scripts for Rails engine."
  p.url            = ""
  p.author         = 'Amar Daxini'
  p.email          = "amar.daxini (at) gmail (dot) com"
  p.ignore_pattern = ["script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
