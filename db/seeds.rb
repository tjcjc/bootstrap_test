# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'json'
str = File.new(File.dirname(__FILE__)+"/resut", "r:utf-8")
json = JSON.parse(str.readline)
json.each do |p_subject|
  name = p_subject["title"]
  p = Subject.create(:name=>name)
  p_subject["childrens"].each do |c_subject|
    p.children.create(c_subject)
  end
end
