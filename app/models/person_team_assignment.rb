# == Schema Information
#
# Table name: person_team_assignments
#
#  id                :integer          not null, primary key
#  person_id         :integer
#  team_id           :integer
#  team_role_type_id :integer
#  startdate         :date
#  enddate           :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PersonTeamAssignment < ActiveRecord::Base
  belongs_to :person,     required: true
  belongs_to :team,       required: true
  belongs_to :team_role_type,  required: true

end
