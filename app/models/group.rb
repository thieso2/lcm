# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  group_type_id :integer
#  title         :string
#  location      :string
#  startdate     :date
#  enddate       :date
#  baseprice     :decimal(8, 2)
#  group_state   :integer          default("0"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Group < ActiveRecord::Base
  enum group_state: [:planning, :open, :started, :ended, :closed]
  
  belongs_to :group_type
  has_many   :assignments
  
  validates :group_type_id, presence: true
  
  scope :course, -> { joins(:course_type).merge(CourseType.course) }
  scope :team,   -> { joins(:course_type).merge(CourseType.team) }
  
  def to_s
    "#{group_type} #{title} #{location}"
  end
  
end
