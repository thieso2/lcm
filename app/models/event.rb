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

class Event < Group
  
  belongs_to :event_type, class_name: :GroupType
  alias_attribute :event_type_id, :group_type_id
  alias_attribute :event_type,    :group_type
  alias_attribute :event_state,   :group_state
  
  validates :location, presence: true
  
  validates_presence_of  :startdate #, :enddate
  # validates :enddate, date: { :after_or_equal_to => :startdate }
  
  default_scope { joins(:group_type).merge(GroupType.course) }

  # scope :open,     -> { where(coursestate: Course.coursestates[:open]).order(:startdate)}
  
  
  def to_s
    "#{event_type.description} in #{location} starting at #{startdate}"
  end
    
end
