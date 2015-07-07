class Importstep < ActiveRecord::Base
  belongs_to  :import
  has_many    :importrow
end
