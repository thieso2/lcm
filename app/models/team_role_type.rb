# == Schema Information
#
# Table name: team_role_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TeamRoleType <  ActiveRecord::Base
end
