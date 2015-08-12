# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  code        :string           not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Region < ActiveRecord::Base
  def to_s
    "#{code}:#{description}"
  end
end
