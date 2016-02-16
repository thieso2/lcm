# == Schema Information
#
# Table name: event_role_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EventRoleType <  ActiveRecord::Base
  def to_s
    description
  end
end
