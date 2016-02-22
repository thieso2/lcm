# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  access                 :integer
#


describe User do

  subject { build(:user) }

  it { should respond_to(:id) }
  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password)}

  it "#email returns a string" do
    expect(subject.email).to match 'user.*@example.com'
  end


end
