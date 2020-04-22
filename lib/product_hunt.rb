require_relative "./product_hunt/version"
require_relative "./product_hunt/cli"
require_relative "./product_hunt/scraper"
require_relative "./product_hunt/product"

require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'


module ProductHunt
  class Error < StandardError; end
  # Your code goes here...
end
