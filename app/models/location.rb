# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  city       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
end
