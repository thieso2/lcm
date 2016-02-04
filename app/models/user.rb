# == Schema Information
#
# Table name: people
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
