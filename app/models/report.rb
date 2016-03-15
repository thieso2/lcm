# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url_name    :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Report < ActiveRecord::Base

  def pot_frankfurt
    Person.select("people.id, lastname, firstname, email")
    .joins(:region)
    .where("(
            EXISTS (SELECT 1 FROM person_event_assignments
              INNER JOIN events ON person_event_assignments.event_id = events.id
              INNER JOIN event_types ON events.event_type_id = event_types.id
              WHERE person_id = people.id AND event_types.code = 'FGK' )
          AND
             (SELECT COUNT(*) FROM person_event_assignments
              INNER JOIN events ON person_event_assignments.event_id = events.id
              INNER JOIN event_types ON events.event_type_id = event_types.id
              WHERE person_id = people.id AND event_types.description LIKE 'Seminar%' ) >= 1
          )

          OR
             (SELECT COUNT(*) FROM person_event_assignments
              INNER JOIN events ON person_event_assignments.event_id = events.id
              INNER JOIN event_types ON events.event_type_id = event_types.id
              WHERE person_id = people.id AND event_types.description LIKE 'Seminar%' ) >= 2
    ")
    .order('lastname, firstname')
  end

  def absolventen_fgk
    fgk = EventType.where(code: 'FGK').first   #.try(:id)
    ffh = Region.where(code: "Frankfurt").first

    Person.select("people.id, lastname, firstname, zip, city, street, housenumber, email, phone_private, phone_work, phone_mobile, birthday, shortname")
    .joins(:region, :person_event_assignments => :event)
    .where("events.event_type_id" => fgk)
    .where(:region => ffh)
    .where("events.startdate >= ?", "20130101")
    .order('lastname, firstname, events.startdate')
  end
end
