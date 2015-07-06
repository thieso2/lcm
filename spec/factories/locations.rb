# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  city       :string           not null
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :location do
    code    "FRK"
    city    "Frankfurt"
  end

end
