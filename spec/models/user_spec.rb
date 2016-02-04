# == Schema Information
#
# Table name: people
#
describe User do

  #before(:each) { @user = User.new(email: 'user@example.com') }
  # subject { @user }
  subject { build(:user) }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(subject.email).to match 'user@example.com'
  end

end
