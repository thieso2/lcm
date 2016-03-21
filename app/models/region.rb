# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Region < ActiveRecord::Base
  def to_s
    "#{code}"
  end
end
