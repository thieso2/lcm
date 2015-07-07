class Import < ActiveRecord::Base
  belongs_to  :person
  has_many    :importstep
end
