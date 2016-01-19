# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if !Rails.env.production?
  load File.dirname(__FILE__) + '/seeds/campaigns.rb'
  load File.dirname(__FILE__) + '/seeds/questions.rb'
  load File.dirname(__FILE__) + '/seeds/participants.rb'
end
