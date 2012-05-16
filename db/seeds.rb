# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Category.create(:name => "Community")
Category.create(:name => "Customer Feedback")
Category.create(:name => "Demographics")
Category.create(:name => "Education")
Category.create(:name => "Events")
Category.create(:name => "Healthcare")
Category.create(:name => "Human Resources")
Category.create(:name => "Industry Specific")
Category.create(:name => "Just for Fun")
Category.create(:name => "Non-Profit")
Category.create(:name => "Political")
Category.create(:name => "Other")

Folder.create(:name => "Red Folder", :html => "<image src=/assets/red.png>")
Folder.create(:name => "Green Folder", :html => "<image src=/assets/green.png>")
Folder.create(:name => "Yellow Folder", :html => "<image src=/assets/yellow.png>")
Folder.create(:name => "Blue Folder", :html => "<image src=/assets/blue.png>")

