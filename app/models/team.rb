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

class Team < Group
  scope :default, -> { joins(:course_type).merge(CourseType.internal) }
  default_scope { joins(:group_type).merge(GroupType.team) }
end
