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

FactoryGirl.define do
  factory :assignment do
    Person nil
    Course nil
    RoleType nil
  end

end
