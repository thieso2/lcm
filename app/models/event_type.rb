# == Schema Information
#
# Table name: event_types
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EventType <  ActiveRecord::Base
  has_many :events

  def to_s
    code + ":" + description
  end

end
