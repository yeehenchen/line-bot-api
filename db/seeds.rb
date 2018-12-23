# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'

url = 'https://www.decathlon.tw/zh/sports'
html_content = open(url).read
doc = Nokogiri::HTML(html_content)
h = Hash.new(0)
doc.search('a').each do |element|
  h[element.text.strip] = element['href']
end

h.each { |k, v| Link.create(word: k, link: v) }
