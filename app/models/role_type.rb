# == Schema Information
#
# Table name: role_types
#
#  id          :integer          not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class RoleType < ActiveRecord::Base
  
  def to_s
    description
  end
  
end
