# == Schema Information
#
# Table name: event_types
#
#  id          :integer          not null, primary key
#  code        :string           not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EventType <  ActiveRecord::Base
  has_many :events
end
