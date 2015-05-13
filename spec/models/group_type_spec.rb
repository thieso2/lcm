# == Schema Information
#
# Table name: group_types
#
#  id          :integer          not null, primary key
#  code        :string           not null
#  description :string           not null
#  category    :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe GroupType, :type => :model do
  subject { create(:group_type) }
  
  it { should have_many(:groups) }
end
