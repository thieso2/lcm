# == Schema Information
#
# Table name: team_types
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :team_type do
    code "ASS"
    description "Assistance Program"
  end
end
