# == Schema Information
#
# Table name: calls
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  date       :datetime
#  caller_id  :integer
#  info       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Call, type: :model do

  it { should belong_to(:person) }

  it { should have_db_column(:info) }

end
