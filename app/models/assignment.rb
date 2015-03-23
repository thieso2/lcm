# == Schema Information
#
# Table name: assignments
#
#  id           :integer          not null, primary key
#  person_id    :integer
#  group_id     :integer
#  role_type_id :integer
#  startdate    :date
#  enddate      :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Assignment < ActiveRecord::Base
  belongs_to :person,     required: true
  belongs_to :group,      required: true
  belongs_to :role_type,  required: true
  
end
