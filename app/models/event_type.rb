# == Schema Information
#
# Table name: event_types
#
#  id          :integer          not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EventType <  ActiveRecord::Base
end
