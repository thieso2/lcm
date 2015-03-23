

class Event < Group
  
  belongs_to :event_type, class_name: :GroupType
  alias_attribute :event_type_id, :group_type_id
  alias_attribute :event_type,    :group_type
  alias_attribute :event_state,   :group_state
  alias_attribute :state,         :group_state
  
  validates :location, presence: true
  
  validates_presence_of  :startdate #, :enddate
  # validates :enddate, date: { :after_or_equal_to => :startdate }
  
  default_scope { joins(:group_type).merge(GroupType.course) }

  scope :open,     -> { where(event_state: Group.group_states[:open]).order(:startdate)}
  
  def self.search(search)
    if search
      events = where(nil)
      events = events.where("shortname like ?", "%#{search[:shortname]}%" )   if search[:shortname].present?
      events = events.where("description like ?", "%#{search[:country]}%")    if search[:description].present?
      # events = events.where("zip like ?", "#{search[:zip]}%" ) if search[:zip].present?
      events = events.where("location like ?", "#{search[:location]}%" )      if search[:location].present?
      events
    else
      where(nil)
    end
    
  end  
  
  def to_s
    "#{event_type.description} in #{location} starting at #{startdate}"
  end
    
end
