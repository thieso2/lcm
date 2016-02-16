# == Schema Information
#
# Table name: event_role_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe EventRoleType, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
