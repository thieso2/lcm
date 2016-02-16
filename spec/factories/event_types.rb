# == Schema Information
#
# Table name: event_types
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :event_type do
    code        "LMF"
    description "Landmark Forum"
  end
end
