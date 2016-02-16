# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  city       :string(255)      not null
#  address    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  def to_s
    "#{code} : #{city}"
  end
end
