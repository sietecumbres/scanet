# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user = User.new :first_name => 'Master', :last_name => 'Master', :email => 'master@scanet.com', :username => 'master'
user.password = 'master'
user.password_confirmation = 'master'
user.save