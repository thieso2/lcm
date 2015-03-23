# == Schema Information
#
# Table name: course_types
#
#  id          :integer          not null, primary key
#  description :string           not null
#  internal    :boolean          default("f"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe CourseType, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
