# == Schema Information
#
# Table name: events
#
#  eid           :integer          primary key
#  event_type_id :integer
#  location_id   :integer
#  shortname     :string(255)
#  title         :string(255)
#  startdate     :date
#  enddate       :date
#  baseprice     :decimal(8, 2)
#  event_state   :integer          default(0), not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'rails_helper'

RSpec.describe Event, :type => :model do
  subject { FactoryGirl.build(:event) }

  it { should belong_to(:event_type) }
  it { should belong_to(:location) }

  it { should have_db_column(:eid) }

  describe "a newly created event" do
    it "should be in state :planning" do
      expect(subject.event_state).to eq("planning")
      expect(subject.planning?).to be true
    end

    it "should have no :id" do
      expect(subject.id).to be_nil
    end

    it "should have an :id after save" do
      subject.location = FactoryGirl.create(:location)
      subject.save!
      expect(subject.id).to_not be_nil
    end
  end

  describe "Class methods" do
    it "should find open events" do
      expect {
        Event.create!(event_type: create(:event_type) , event_state: :open, location: create(:location) , startdate: Date.today)
      }.to change{ Event.open.count }.by(1)
    end
  end

end
