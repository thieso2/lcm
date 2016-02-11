# == Schema Information
#
# Table name: events
#
#  eid           :integer          primary key
#  event_type_id :integer
#  location_id   :integer
#  shortname     :string
#  title         :string
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
