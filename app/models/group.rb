# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  group_type_id :integer
#  locations_id  :integer
#  eid           :integer
#  shortname     :string
#  title         :string
#  startdate     :date
#  enddate       :date
#  baseprice     :decimal(8, 2)
#  group_state   :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Group < ActiveRecord::Base
  enum group_state: [:planning, :open, :started, :ended, :closed]
  
  belongs_to  :group_type
  belongs_to  :location
  has_many    :assignments
  
  validates :group_type_id, presence: true
  
  scope :event, -> { joins(:group_type).merge(GroupType.event) }
  scope :team,  -> { joins(:group_type).merge(GroupType.team) }
  
  def to_s
    # "#{group_type} #{title} #{location}"
    "#{title} #{location}"
  end
  
end
