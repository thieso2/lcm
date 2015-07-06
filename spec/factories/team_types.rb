# == Schema Information
#
# Table name: team_types
#
#  id          :integer          not null, primary key
#  code        :string           not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :team_type do
    code "ASS"
    description "Assistance Program"
  end
end
