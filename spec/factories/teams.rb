# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  team_type_id :integer
#  region_id    :integer
#  tid          :integer
#  shortname    :string
#  title        :string
#  startdate    :date
#  enddate      :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :team do
    association   :team_type
  end
end

