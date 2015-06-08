# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << admin.email

# user = Person.create!(firstname: "Klaus", sex: :male )
klaus = Person.create!(firstname: "klaus", lastname: "Gundermann", sex: :male, country: "DE" )

loc_ger = Location.create! code: "GER", city: "Germany"
loc_frk = Location.create! code: "FRK", city: "Frankfurt"
loc_ham = Location.create! code: "HAM", city: "Hamburg"
loc_muc = Location.create! code: "MUC", city: "München"
loc_lnd = Location.create! code: "LND", city: "London"

gt_lmf = GroupType.create! code: "LMF", description: "Landmark Forum",        category: :event
gt_fgk = GroupType.create! code: "FGK", description: "Fortgeschrittenenkurs", category: :event
gt_exc  = GroupType.create! code: "EXC", description: "Seminar Excellence",   category: :event
gt_cap  = GroupType.create! code: "CAP", description: "Seminar Kommunikation: Zugang durch Kraft",category: :event
gt_cpc  = GroupType.create! code: "CPC", description: "Seminar Kommunikation: die Kraft zu Kreieren",category: :event
gt_fia  = GroupType.create! code: "FIA", description: "Seminar Forum in Aktion",category: :event

gt_assist = GroupType.create! code: "ASS", description: "Assistance Programm", category: :team
gt_admins = GroupType.create! code: "ADM", description: "Administration",      category: :team

rl_fol   = RoleType.create! description: "Forum Leader"
rl_fos   = RoleType.create! description: "Forum Supervisor"
rl_om    = RoleType.create! description: "Operations Manager"
rl_att   = RoleType.create! description: "Attendee"
rl_int   = RoleType.create! description: "Interested"
rl_ass   = RoleType.create! description: "Assistant"
rl_admin = RoleType.create! description: "Administrator"

admins = Team.create!(group_type: gt_admins, title: "Germany", startdate: "2015-01-01")

puts "Created Team: #{admins}"

Assignment.create!(person: klaus, group: admins, role_type: rl_admin)

if false

# -----------------------------------------------------------------
# Create Landmark Forum Frankfurt 2015/05

forum = Event.create!(event_type: gt_lmf, location: loc_frk,
                      startdate: "2015-05-01", event_state: "open")
puts "Created Event: #{forum}"

Assignment.create!(person: klaus, group: forum, role_type: rl_att)

# -----------------------------------------------------------------
# Create Seminar Excellence Munich 2015/02-03

excellence = Event.create!(event_type: gt_se, location: loc-muc,
                           startdate: "2015-02-01", event_state: "open")
puts "Created Event: #{excellence}"

Assignment.create!(person: klaus, group: excellence, role_type: rl_att)

# -----------------------------------------------------------------
# Create Assistance Programm Germany

assistance = Event.create!(event_type: gt_assist, location: loc_ger,
                           startdate: "2010-01-01", event_state: "open")
puts "Created Event: #{assistance}"

Assignment.create!(person: klaus, group: assistance, role_type: rl_ass, startdate: "2015-02-01", enddate: "2015-03-31")

end
