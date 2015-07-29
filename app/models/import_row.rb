# == Schema Information
#
# Table name: import_rows
#
#  id             :integer          not null, primary key
#  import_step_id :integer
#  row            :integer
#  rawdata        :string
#  importdata     :string
#  conflictdata   :string
#  state          :integer
#  message        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ImportRow < ActiveRecord::Base
  belongs_to  :import_step

  scope :by_state, ->(state) {
    debugger
    case state
      when :all     then where(true)
      when :valid   then valid
      when :invalid then invalid
    end
    }
  scope :valid,   -> { where(message: '')}
  scope :invalid, -> { where.not(message: '')}
  default_scope   -> { where.not(message: '')}

  def to_s
    "Row ##{row} #{rawdata} =>>> #{importdata} #{state} #{message}"
  end

end
