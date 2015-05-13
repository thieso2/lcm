
FactoryGirl.define do
  factory :group do
    association   :group_type

    locations_id    1
    startdate       DateTime.now
  end

end
