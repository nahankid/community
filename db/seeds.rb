# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def make_admin
  ag = Group.create!(name: 'Administrators')
	au = User.create!(email: 'nahankid@gmail.com', password: "hello123")
	au.groups << ag
end

def fake_groups
	print "Populating groups"

  9.times do |n|
    print '.'
    ch = Group.create!(name: Faker::Lorem.word)
    Random.new.rand(1..5).times do |n1|
      ch1 = ch.children.create!(name: Faker::Lorem.word)
      Random.new.rand(1..5).times do |n2|
        ch1.children.create!(name: Faker::Lorem.word)
      end
    end
  end

	puts "done!"
end

def fake_all
	make_admin
  fake_groups
end

fake_all