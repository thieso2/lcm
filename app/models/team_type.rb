# == Schema Information
#
# Table name: team_types
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TeamType <  ActiveRecord::Base
  has_many :teams

  def to_s
    code + ":" + description
  end
end
