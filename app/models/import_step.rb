class ImportStep < ActiveRecord::Base
  belongs_to  :import
  has_many    :import_row
end
