# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  event_type_id :integer
#  location_id   :integer
#  shortname     :string(255)
#  title         :string(255)
#  startdate     :date
#  enddate       :date
#  baseprice     :decimal(8, 2)
#  event_state   :integer          default(0), not null
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :event do
    association   :event_type

    #locations_id    1
    startdate       DateTime.now
  end

end
