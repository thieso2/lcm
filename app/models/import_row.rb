# == Schema Information
#
# Table name: import_rows
#
#  id             :integer          not null, primary key
#  import_step_id :integer
#  row            :integer
#  rawdata        :text(65535)
#  importdata     :text(65535)
#  conflictdata   :text(65535)
#  state          :integer
#  message        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ImportRow < ActiveRecord::Base
  belongs_to :import_step

  scope :by_state, ->(state) {
    case state
      when :all     then where(true)
      when :valid   then valid
      when :invalid then invalid
    end
  }
  scope :valid,   -> { where(state: 1) }
  scope :invalid, -> { where(state: 2) }
  # default_scope   -> { where(state: 2) }

  def to_s
    "Row ##{row} #{rawdata} =>>> #{importdata} #{state} #{message}"
  end
  def to_html
    "<div class=\"column\">#{rawdata}</div>" +
    "<div class=\"column\">#{importdata}</div>" +
    "<div class=\"column\">#{message}</div>"
  end

  def message=(array)
    if array.empty?
      self.state = 1
    else
      self.state = 2
      super
    end
  end

  def has_error?
    self.state == 2
  end

end
