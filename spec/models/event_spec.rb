# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  event_type_id :integer
#  location_id   :integer
#  eid           :integer
#  shortname     :string
#  title         :string
#  startdate     :date
#  enddate       :date
#  baseprice     :decimal(8, 2)
#  event_state   :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, :type => :model do
  subject { FactoryGirl.build(:event) }

  it { should belong_to(:event_type) }
  # ?? it { should belong_to(:event_state) }

  it { should have_db_column(:eid) }

end
