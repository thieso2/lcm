# == Schema Information
#
# Table name: people
#
#  id             :integer          not null, primary key
#  region_id      :integer
#  firstname      :string(255)
#  lastname       :string(255)
#  callby         :string(255)
#  sex            :string(255)
#  title          :string(255)
#  country        :string(255)
#  region         :string(255)
#  zip            :string(255)
#  city           :string(255)
#  street         :string(255)
#  housenumber    :string(255)
#  birthday       :date
#  email          :string(255)
#  state          :string(255)
#  date           :string(255)
#  phone_private  :string(255)
#  phone_work     :string(255)
#  phone_mobile   :string(255)
#  notes          :text(65535)
#  do_not_contact :boolean
#


RSpec.describe Person, :type => :model do

  subject { build(:person) }

  it { should respond_to(:firstname ) }
  it { should respond_to(:lastname ) }
  it { should respond_to(:fullname ) }

  it { should belong_to(:region) }

  it { should have_many(:calls) }

  it { should have_many(:person_event_assignments) }
  it { should have_many(:person_team_assignments) }

  describe "a newly created person"  do

    it "should get a new id after saving" do
      expect(subject.id). to be nil
      subject.save!
      expect(subject.id). to be > 0
    end

    it "should have a default country" do
      expect(subject.country).to eq("DE")
    end

  end

end
