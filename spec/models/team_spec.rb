# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  team_type_id :integer
#  region_id    :integer
#  shortname    :string
#  title        :string
#  startdate    :date
#  enddate      :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

RSpec.describe Team, :type => :model do
  subject { FactoryGirl.build(:team) }

  it { should belong_to(:team_type) }
end
