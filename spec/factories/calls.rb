# == Schema Information
#
# Table name: calls
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  date       :datetime
#  caller_id  :integer
#  info       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :call, aliases: [:phonecall] do

  end

end
