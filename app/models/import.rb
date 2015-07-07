class Import < ActiveRecord::Base
  belongs_to  :user
  has_many    :importstep
end
