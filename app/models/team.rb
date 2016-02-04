# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  team_type_id :integer
#  region_id    :integer
#  tid          :integer
#  shortname    :string
#  title        :string
#  startdate    :date
#  enddate      :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Team < ActiveRecord::Base
  belongs_to :team_type
  belongs_to :region
  has_and_belongs_to_many :person

  # default_scope { joins(:team_type).merge(TeamType.team) }

  def self.search(search)
    if search
      events = where(nil)
      events = events.where("shortname like ?",   "%#{search[:shortname]}%" )   if search[:shortname].present?
      events = events.where("title like ?",       "%#{search[:title]}%")        if search[:title].present?
      events = events.where("description like ?", "%#{search[:description]}%")  if search[:description].present?
      events = events.where("region like ?",      "#{search[:region]}%" )     if search[:location].present?
      # events = events.where("event_state = ?",     search[:state].to_i )        if search[:state].present?
      events
    else
      where(nil)
    end
  end

  def assistants
    #self.assignments.joins(:role_type).joins(:person).includes(:role_type).includes(:person).order("people.lastname")
  end


  def to_s
    "#{team_type.description} in #{region} starting at #{startdate}"
  end

end
