# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  fromfile   :string
#  starttime  :datetime
#  finishtime :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Import, type: :model do
   it { should have_many(:importstep) }
end
