# == Schema Information
#
# Table name: calls
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  date       :datetime
#  caller_id  :integer
#  info       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :call do
    
  end

end
