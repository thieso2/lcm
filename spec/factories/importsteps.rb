FactoryGirl.define do
  factory :importstep do
    import ""
    description "MyString"
    totalrows 100
    validrows 99
    errorrows 1
  end

end
