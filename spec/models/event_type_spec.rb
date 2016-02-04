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

require 'rails_helper'

RSpec.describe EventType, :type => :model do
  # subject { create(:event_type) }

  it { should have_many(:events) }
end
