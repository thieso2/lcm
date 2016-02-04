# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  code        :string           not null
#  description :string
#  created_at  :datetime
#  updated_at  :datetime
#

class Region < ActiveRecord::Base
  def to_s
    "#{code}:#{description}"
  end
end
