class Importrow < ActiveRecord::Base
  belongs_to  :import
  has_many    :importrow
end
