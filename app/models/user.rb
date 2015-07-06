# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
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
#  regions_id             :integer
#  pid                    :integer
#  firstname              :string
#  lastname               :string
#  sex                    :string
#  salutation             :integer
#  country                :string
#  region                 :string
#  zip                    :string
#  city                   :string
#  street                 :string
#  housenumber            :string
#  birthday               :date
#  phone_private          :string
#  phone_work             :string
#  phone_mobile           :string
#  notes                  :string
#  do_not_contact         :boolean
#  access                 :integer
#

class User < ActiveRecord::Base  # ?< Person
  extend Enumerize
  # versioned
  has_paper_trail

  self.table_name = "people"

  enum access: [:person, :assistant, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
    email
  end

end
