# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


FactoryGirl.create(:manager)
FactoryGirl.create(:admin)

10.times { FactoryGirl.create(:user) }
10.times { FactoryGirl.create(:city) }
20.times { FactoryGirl.create(:ship_request) }


