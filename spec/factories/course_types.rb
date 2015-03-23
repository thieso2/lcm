# == Schema Information
#
# Table name: course_types
#
#  id          :integer          not null, primary key
#  description :string           not null
#  internal    :boolean          default("f"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :course_type do
    description "MyString"
  end

end
