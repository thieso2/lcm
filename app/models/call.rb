class Call < ActiveRecord::Base
  belongs_to :person
  belongs_to :caller, class_name: "Person"
end
