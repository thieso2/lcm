# == Schema Information
#
# Table name: people
#
#  pid                    :integer          not null, primary key
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
#  region_id              :integer
#  firstname              :string(255)
#  lastname               :string(255)
#  callby                 :string(255)
#  sex                    :string(255)
#  title                  :string(255)
#  country                :string(255)
#  region                 :string(255)
#  zip                    :string(255)
#  city                   :string(255)
#  street                 :string(255)
#  housenumber            :string(255)
#  birthday               :date
#  state                  :string(255)
#  date                   :string(255)
#  phone_private          :string(255)
#  phone_work             :string(255)
#  phone_mobile           :string(255)
#  notes                  :text(65535)
#  do_not_contact         :boolean
#  access                 :integer
#

describe User do

  subject { build(:user) }

  it { should respond_to(:pid) }
  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password)}

  it "#email returns a string" do
    expect(subject.email).to match 'user.*@example.com'
  end


end
