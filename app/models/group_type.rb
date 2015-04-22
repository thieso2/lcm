# == Schema Information
#
# Table name: group_types
#
#  id          :integer          not null, primary key
#  description :string           not null
#  category    :integer          default("0"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GroupType < ActiveRecord::Base
  enum category: [:event, :team]
  
  has_many :groups  
  
  #scope :team, -> { where(internal: true) }
  #scope :course, -> { where(internal: false) }

  def to_s
    description
  end
  
end
