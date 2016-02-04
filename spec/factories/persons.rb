FactoryGirl.define do
  factory :person do
    firstname "Important"
    lastname  "Person"
    email     "Person@example.com"

=begin
    factory :person_with_calls do
      transient do
        calls_count 5
      end

      after(:create) do |person, evaluator|
        create_list(:call, evaluator.calls_count, person: person)
      end
    end

    factory :person_with_events do
      #association :event

      after(:create) do |person, evaluator|
        create_list(:person_event_assignments, evaluator.calls_count, person: person)
      end
    end

=end

  end
end
