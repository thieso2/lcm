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
klaus = Person.create!(firstname: "Klaus", lastname: "Gundermann", sex: :male, country: "DE" )

reg_ger = Region.create! code: "GER", description: "Germany"

loc_frk = Location.create! code: "FRK", city: "Frankfurt"
loc_ham = Location.create! code: "HAM", city: "Hamburg"
loc_muc = Location.create! code: "MUC", city: "München"
loc_bln = Location.create! code: "BLN", city: "Berlin"
loc_lnd = Location.create! code: "LND", city: "London"

evt_lmf  = EventType.create! code: "LMF", description: "Landmark Forum"
evt_fgk  = EventType.create! code: "FGK", description: "Fortgeschrittenenkurs"
evt_wis  = EventType.create! code: "WIS", description: "Wisdom"
evt_ilp  = EventType.create! code: "ILP", description: "Einführungsleiterprogramm"

evt_exc  = EventType.create! code: "EXC", description: "Seminar Excellence"
evt_cap  = EventType.create! code: "CAP", description: "Seminar Kommunikation: Zugang durch Kraft"
evt_cpc  = EventType.create! code: "CPC", description: "Seminar Kommunikation: die Kraft zu Kreieren"
evt_fia  = EventType.create! code: "FIA", description: "Seminar Forum in Aktion"
evt_suc  = EventType.create! code: "SUC", description: "Seminar Erfolg"
evt_ges  = EventType.create! code: "GES", description: "Seminar Geschwindigkeit"
evt_mir  = EventType.create! code: "MIR", description: "Seminar Wunder"
evt_inl  = EventType.create! code: "INL", description: "Seminar Ein Kreirtes Leben leben"
evt_int  = EventType.create! code: "INT", description: "Seminar Integrität"
evt_eff  = EventType.create! code: "EFF", description: "Seminar Effektivität"
evt_mon  = EventType.create! code: "MON", description: "Seminar Geld"
evt_rel  = EventType.create! code: "REL", description: "Seminar Beziehung"
evt_blb  = EventType.create! code: "BLB", description: "Seminar Durchbrüche"

tt_assist = TeamType.create! code: "ASS", description: "Assistance Programm"
tt_admins = TeamType.create! code: "ADM", description: "Administration"

rl_fol   = EventRoleType.create! description: "Forum Leader"
rl_fos   = EventRoleType.create! description: "Forum Supervisor"
rl_om    = EventRoleType.create! description: "Operations Manager"
rl_att   = EventRoleType.create! description: "Attendee"
rl_int   = EventRoleType.create! description: "Interested"

rl_admin = TeamRoleType.create! description: "Administrator"
rl_ass   = TeamRoleType.create! description: "Assistant"

admins = Team.create!(team_type: tt_admins, title: "Germany", startdate: "2015-01-01")

puts "Created Team: #{admins}"

PersonTeamAssignment.create!(person: klaus, team: admins, team_role_type: rl_admin)

# -----------------------------------------------------------------
# Create Landmark Forum Frankfurt 2015/05

forum = Event.create!(event_type: evt_lmf, location: loc_frk,
                      startdate: "2015-05-01", event_state: "open")
puts "Created Event: #{forum}"

PersonEventAssignment.create!(person: klaus, event: forum, event_role_type: rl_att)

# -----------------------------------------------------------------
# Create Seminar Excellence Munich 2015/02-03

excellence = Event.create!(event_type: evt_exc, location: loc_muc,
                           startdate: "2015-02-01", event_state: "open")
puts "Created Event: #{excellence}"

PersonEventAssignment.create!(person: klaus, event: excellence, event_role_type: rl_att)

# -----------------------------------------------------------------
# Create Assistance Programm Germany

assistance = Team.create!(team_type: tt_assist, region: reg_ger)
puts "Created Event: #{assistance}"

PersonTeamAssignment.create!(person: klaus, team: assistance, team_role_type: rl_ass, startdate: "2015-02-01", enddate: "2015-03-31")
