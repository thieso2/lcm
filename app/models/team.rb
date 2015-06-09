# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  team_type_id :integer
#  regions_id   :integer
#  tid          :integer
#  shortname    :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Team < ActiveRecord::Base
  default_scope { joins(:team_type).merge(TeamType.team) }
end
