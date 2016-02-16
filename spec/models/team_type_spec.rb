# == Schema Information
#
# Table name: team_types
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe TeamType, type: :model do
  it { should have_many :teams }
end
