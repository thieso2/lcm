
FactoryGirl.define do
  factory :event do
    association   :event_type
    #association   :group_type

    locations_id    1
    startdate       DateTime.now
  end

end
