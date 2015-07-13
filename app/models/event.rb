# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  event_type_id :integer
#  location_id   :integer
#  eid           :integer
#  shortname     :string
#  title         :string
#  startdate     :date
#  enddate       :date
#  baseprice     :decimal(8, 2)
#  event_state   :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Event < ActiveRecord::Base

  enum event_state: [:planning, :open, :started, :ended, :closed]

  belongs_to :event_type
  belongs_to :location

  validates :location_id, presence: true


  validates_presence_of  :startdate #, :enddate
  # validates :enddate, date: { :after_or_equal_to => :startdate }

  default_scope { joins(:event_type) }

  scope :open, -> { where(event_state: Group.group_states[:open]).order(:startdate)}

  def self.search(search)
    if search
      events = where(nil)
      events = events.where("shortname like ?",   "%#{search[:shortname]}%" )   if search[:shortname].present?
      events = events.where("title like ?",       "%#{search[:title]}%")        if search[:title].present?
      events = events.where("description like ?", "%#{search[:description]}%")  if search[:description].present?
      events = events.where("location like ?",    "#{search[:location]}%" )     if search[:location].present?
      events = events.where("event_state = ?",     search[:state].to_i )        if search[:state].present?
      events
    else
      where(nil)
    end

  end

  def to_s
    "#{eid} #{event_type} in #{location} starting at #{startdate}"
  end

  def attendees
    #self.assignments.joins(:role_type).joins(:person).includes(:person).order("people.lastname")
  end

  def assistants
    #self.assignments.joins(:role_type).joins(:person).includes(:role_type).includes(:person).order("people.lastname")
  end

  def startdate_code
    startdate.strftime("%y%m")
  end

  # --------------------------------------------------------

  def city=(city)
     l = Location.where(city: city).first
     self.location = l if l
  end

  def setshortname=(shortname)

    if shortname[0,3] == "Sem"
      evtcode = shortname[-3,3]
    elsif shortname[0,3] == "ILP"
      evtcode = shortname[-3,3]
      loc = Location.where(code: "GER")
    else
      evtcode = shortname[0,3]
    end
    evt = EventType.where(code: evtcode).first
    self.event_type = evt

    if self.location.nil?
      loccode = shortname[3,3]
      loc = Location.where(code: loccode).first
      self.location = loc
    end

  end


  before_save do
    if self.shortname.nil?
      self.shortname = event_type.code +  location.code + startdate_code
    end
    if self.title.nil?
      self.title = event_type.description
    end
  end

end
