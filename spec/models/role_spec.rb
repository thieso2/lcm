# == Schema Information
#
# Table name: roles
#
#  id           :integer          not null, primary key
#  person_id    :integer
#  course_id    :integer
#  role_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Role, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
