# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  email                  :string           default("")
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  firstname              :string
#  lastname               :string
#  callby                 :string
#  sex                    :string
#  title                  :string
#  country                :string
#  region                 :string
#  zip                    :string
#  city                   :string
#  street                 :string
#  housenumber            :string
#  birthday               :date
#  phone_private          :string
#  phone_work             :string
#  phone_mobile           :string
#  notes                  :string
#  pid                    :integer
#  do_not_contact         :boolean
#  access                 :integer
#

class Person < ActiveRecord::Base
  extend Enumerize
  # versioned
  has_paper_trail

  enum access: [:person, :assistant, :admin]
  enumerize :sex, in: [:other, :female, :male]

  after_initialize :set_default_values, :if => :new_record?
  after_initialize :set_default_access, :if => :new_record?

  has_many :assignments
  has_many :calls

  # validates :sex,      presence: true
  validates :lastname, presence: true
  validates :country,  presence: true

  def self.search(search)
    if search
      people = where("pid > 1")
      people = people.where("pid = ?",          "#{search[:pid]}" )      if search[:pid].present?
      people = people.where("lastname ilike ?", "#{search[:lastname]}%" ) if search[:lastname].present?
      people = people.where("country = ?",      "#{search[:country]}" )   if search[:country].present?
      people = people.where("zip like ?",       "#{search[:zip]}%" )      if search[:zip].present?
      people = people.where("city like ?",      "#{search[:city]}%" )     if search[:city].present?
      people
    else
      where(nil)
    end

  end

  def fullname
    "#{firstname} #{lastname}"
  end
  def to_s
    fullname
  end

  def assign_to(group, role)
    assignments.create!(group: group, role_type: role)
  end

  def events
    Assignment.where(Person_id: id).joins(group: :group_type).merge(GroupType.event)
  end

  def teams
    Assignment.where(Person_id: id).joins(group: :group_type).merge(GroupType.team)
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

  def status=(value)
    if value == "DNC"
      self.do_not_contact = true
    end
  end

  private
  def set_default_values
    self.country ||= "DE"
  end
  def set_default_access
    self.access ||= :person
  end

end
