# == Schema Information
#
# Table name: role_types
#
#  id          :integer          not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :role_type do
    description "MyString"
  end

end
