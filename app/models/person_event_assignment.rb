# == Schema Information
#
# Table name: person_event_assignments
#
#  id                 :integer          not null, primary key
#  person_id          :integer
#  event_id           :integer
#  event_role_type_id :integer
#  startdate          :date
#  enddate            :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class PersonEventAssignment < ActiveRecord::Base
  belongs_to :person,     required: true
  belongs_to :event,      required: true
  belongs_to :event_role_type,  required: true

  def to_s
    "Person #{person} is assigned to Event #{event} in Role #{event_role_type}"
  end

end
