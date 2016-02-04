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

class Location < ActiveRecord::Base
  def to_s
    "#{code} : #{city}"
  end
end
