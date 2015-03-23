# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  course_type_id :integer
#  location       :string           not null
#  startdate      :date
#  enddate        :date
#  coursestate    :integer          default("0"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :course do
    location "MyString"
startdate "2015-02-02"
enddate "2015-02-02"
coursestate 1
  end

end
