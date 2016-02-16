# == Schema Information
#
# Table name: events
#
#  eid           :integer          primary key
#  event_type_id :integer
#  location_id   :integer
#  shortname     :string(255)
#  title         :string(255)
#  startdate     :date
#  enddate       :date
#  baseprice     :decimal(8, 2)
#  event_state   :integer          default(0), not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Event < ActiveRecord::Base

  self.primary_key = :eid

  STATUSES = [:planning, :open, :started, :ended, :closed]
  enum event_state: STATUSES

  belongs_to :event_type
  belongs_to :location

  has_many   :person_event_assignments

  validates :event_type_id, presence: true
  validates :location_id,   presence: true

  validates_presence_of  :startdate #, :enddate
  # validates :enddate, date: { :after_or_equal_to => :startdate }

  default_scope { joins(:event_type).order(:startdate) }

  # scope :open, -> { where(event_state: Event.open).order(:startdate)}

  def self.shortname_from_filename(filename)
    return if filename.blank?

    filename = filename.upcase
    if filename.start_with? "SEM"
      prefix  = "Sem"
      evtcode =  filename[11,3]
      loccode = filename[3,3]
      ym_code = filename[6,4]
    elsif filename.start_with? "WISUNLIMITED"
      prefix  = ""
      evtcode = "WIS"
      loccode = "EUR"
      ym_code = "0000"
    elsif filename.start_with? "WIS_FuEv"
      prefix  = ""
      evtcode = "WFW"
      loccode = "HAN"
      ym_code = filename[9,4]
    elsif filename.start_with? == "ILP"
      prefix  = ""
      evtcode = "ILP"
      loccode = "GER"
      ym_code = filename[3,3]
    else
      prefix  = ""
      evtcode = filename[0,3]
      loccode = filename[3,3]
      ym_code = filename[6,4]
    end
    return prefix + evtcode + loccode + ym_code
  end

  def self.search(search)
    if search
      events = where(nil)
      events = events.where("shortname like ?",   "%#{search[:shortname]}%" )   if search[:shortname].present?
      events = events.where("title like ?",       "%#{search[:title]}%")        if search[:title].present?
      events = events.where("description like ?", "%#{search[:description]}%")  if search[:description].present?
      events = events.where("location_id = ?",     search[:location].to_i )     if search[:location].present?
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
    self.person_event_assignments.includes(:person).order("people.lastname")
  end

  def assistants
    #self.assignments.joins(:role_type).joins(:person).includes(:role_type).includes(:person).order("people.lastname")
  end

  def startdate_code
    startdate.strftime("%y%m")
  end

  def year
    startdate.year
  end

  # --------------------------------------------------------

  def city=(city)
     l = Location.where(city: city).first
     self.location = l if l
  end

  def filename=(filename)
    self.shortname = Event.shortname_from_filename(filename)
  end

  def shortname=(shortname)
    super
    if shortname.start_with?("Sem")
      evtcode = shortname[0,6]
      loccode = shortname[6,3]
      ym_code = shortname[9,4]
    else
      evtcode = shortname[0,3]
      loccode = shortname[3,3]
      ym_code = shortname[6,4]
    end

    evt = EventType.where(code: evtcode).first
    if evt.nil?
      logger.error "EventType #{evtcode} not found"
    else
      self.event_type = evt
    end

    if self.location.nil?
      loc = Location.where(code: loccode).first
      self.location = loc
    end

    if self.startdate.nil? && ym_code
      self.startdate = "20" + ym_code + "01"   # Year Month and Day "01"
    end

  end


  before_save do
    #if self.filename.nil?
    #  self.filename = event_type.code + location.code + startdate_code
    #end
    if self.title.nil?
      self.title = event_type.description
    end
  end

end
