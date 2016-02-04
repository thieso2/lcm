
RSpec.describe Person, :type => :model do

  subject { build(:person) }

  it { should respond_to(:firstname ) }
  it { should respond_to(:lastname ) }
  it { should respond_to(:fullname ) }

  it { should have_many(:calls) }
  it { should have_many(:person_event_assignments) }
  it { should have_many(:person_team_assignments) }

  describe "a newly created person"  do
    it "should have a default country" do
      expect(subject.country).to eq("DE")
    end
  end


end
