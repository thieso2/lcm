# == Schema Information
#
# Table name: import_steps
#
#  id            :integer          not null, primary key
#  import_job_id :integer
#  description   :string(255)
#  totalrows     :integer
#  validrows     :integer
#  errorrows     :integer
#  errortext     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe ImportStep, type: :model do
  it { should have_many(:import_row) }
end
