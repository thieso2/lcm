# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url_name    :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :report do
    name        "MyString"
    url_name    "MyString"
    description "MyString"
  end

end
