# == Schema Information
#
# Table name: people
#
#  id             :integer          not null, primary key
#  region_id      :integer
#  firstname      :string(255)
#  lastname       :string(255)
#  callby         :string(255)
#  sex            :string(255)
#  title          :string(255)
#  country        :string(255)
#  region         :string(255)
#  zip            :string(255)
#  city           :string(255)
#  street         :string(255)
#  housenumber    :string(255)
#  birthday       :date
#  email          :string(255)
#  state          :string(255)
#  date           :string(255)
#  phone_private  :string(255)
#  phone_work     :string(255)
#  phone_mobile   :string(255)
#  notes          :text(65535)
#  do_not_contact :boolean
#


class Person < ActiveRecord::Base

  nilify_blanks

  # track changes to model data
  has_paper_trail

  extend Enumerize

  enumerize :sex, in: [:other, :female, :male]

  after_initialize :set_default_values, :if => :new_record?

  before_validation {if self.id.blank? then self.id = Person.new_pid end} # in theory this could give the same pid for two concurrent actions

  has_many :calls
  has_many :person_team_assignments
  has_many :person_event_assignments

  belongs_to :region

  # validates :sex,      presence: true
  validates :id,        presence: true
  validates :lastname,  presence: true
  validates :country,   presence: true

  def self.search(search)
    if search
      people = where("id > 1")
      people = people.where("id = ?",           "#{search[:pid]}" )       if search[:pid].present?
      people = people.where("lastname like ?",  "#{search[:lastname]}%" ) if search[:lastname].present?
      people = people.where("country = ?",      "#{search[:country]}" )   if search[:country].present?
      people = people.where("zip like ?",       "#{search[:zip]}%" )      if search[:zip].present?
      people = people.where("city like ?",      "#{search[:city]}%" )     if search[:city].present?
      people
    else
      where(nil)
    end

  end

  def self.new_pid
    1 + Person.maximum(:id).to_i
  end


  def fullname
    "#{lastname}, #{firstname}"
  end
  def to_s
    "#{lastname}, #{firstname} #{country}-#{zip} #{city}"
  end

  def assign_to_event(event, role)
    unless person_event_assignments.exists?(event: event)
      person_event_assignments.create!(event: event, event_role_type: role)
    end
  end

  def event_assignments
    person_event_assignments.joins(:event).order("events.startdate DESC")
  end

  def team_assignments
    person_team_assignments # .joins(group: :group_type).merge(GroupType.team)
  end

  def salutation
    I18n.translate self.sex
  end

  def salutation=(value)
    case value
      when "Herr"
        self.sex = :male
      when "Frau"
        self.sex = :female
      else
        self.sex = :other
    end
  end

  def callby=(name)
    super unless name==self.firstname
  end

  def country=(value="DE")
    if value == "D"
      self.country="DE"
    elsif value.nil?
      # do nothing
    else
      super
    end
  end

  def region=(region)
    return if region.blank?

    r = Region.where(code: region).first
    if r
      super r
    else
      super Region.create!(code: region)
    end
  end


  def status=(value)
    if value == "DNC"
      self.do_not_contact = true
    end
  end

  def ooa_es=(value)
    if value == "Y" || value == "y" || value == "J" || value == "j"
      super true
    else
      super value # don't overwrite a nil value with false
    end
  end

  def ooa_sem=(value)
    if value == "Y" || value == "y" || value == "J" || value == "j"
      super true
    else
      super value # don't overwrite a nil value with false
    end
  end

  private
  def set_default_values
    self.country ||= "DE"
  end

end
