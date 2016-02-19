# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url_name    :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Report, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
