#require 'rubygems'
#require 'RMagick'
#require 'gruff'
#
#
#   g = Gruff::Pie.new
#   g.title = "Visual Pie Graph Test"
#   g.data 'Fries', 20
#   g.data 'Hamburgers', 50
#   g.write("pie_keynote.png")


require 'rubygems'
require 'gruff'

g = Gruff::Line.new
#g.font = "c:/windows/fonts/SIMHEI.TTF"
g.title = "Hi There"

g.data("Apples", [1, 2, 3, 4, 4, 3])
g.data("Oranges", [4, 8, 7, 9, 8, 9])
g.data("Watermelon", [2, 3, 1, 5, 6, 8])
g.data("Peaches", [9, 9, 10, 8, 7, 9])

g.labels = {0 => '2003', 2 => '2004', 4 => '2005'}

g.write('my_fruity_graph.png')
