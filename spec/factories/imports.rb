# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  fromfile   :string
#  starttime  :datetime
#  finishtime :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :import do
    fromfile    "MyString"
    starttime   ""
    finishtime  ""
    person nil
  end

end
