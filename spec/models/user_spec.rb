# == Schema Information
#
# Table name: people
#
#  pid                    :integer          not null, primary key
#  email                  :string           default("")
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  region_id              :integer
#  firstname              :string
#  lastname               :string
#  callby                 :string
#  sex                    :string
#  title                  :string
#  country                :string
#  region                 :string
#  zip                    :string
#  city                   :string
#  street                 :string
#  housenumber            :string
#  birthday               :date
#  state                  :string
#  date                   :string
#  phone_private          :string
#  phone_work             :string
#  phone_mobile           :string
#  notes                  :string
#  do_not_contact         :boolean
#  access                 :integer
#

describe User do

  subject { build(:user) }

  it { should respond_to(:pid) }
  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password)}

  it "#email returns a string" do
    expect(subject.email).to match 'user@example.com'
  end


end
