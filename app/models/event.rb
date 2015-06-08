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



class Event < Group

  belongs_to :event_type #, class_name: :GroupType
  alias_attribute :event_type_id, :group_type_id
  alias_attribute :event_type,    :group_type
  alias_attribute :event_state,   :group_state
  alias_attribute :state,         :group_state

  validates :locations_id, presence: true

  validates_presence_of  :startdate #, :enddate
  # validates :enddate, date: { :after_or_equal_to => :startdate }

  default_scope { joins(:group_type).merge(GroupType.event) }

  scope :open,     -> { where(event_state: Group.group_states[:open]).order(:startdate)}

  def self.search(search)
    if search
      events = where(nil)
      events = events.where("shortname like ?",   "%#{search[:shortname]}%" )   if search[:shortname].present?
      events = events.where("title like ?",       "%#{search[:title]}%")        if search[:title].present?
      events = events.where("description like ?", "%#{search[:description]}%")  if search[:description].present?
      events = events.where("location like ?",    "#{search[:location]}%" )     if search[:location].present?
      events = events.where("group_state = ?",     search[:state].to_i )        if search[:state].present?
      events
    else
      where(nil)
    end

  end

  def to_s
    "#{event_type.description} in #{location} starting at #{startdate}"
  end

  def attendees
    self.assignments.joins(:role_type).joins(:person).includes(:person).order("people.lastname")
  end

  def assistants
    self.assignments.joins(:role_type).joins(:person).includes(:role_type).includes(:person).order("people.lastname")
  end

end
