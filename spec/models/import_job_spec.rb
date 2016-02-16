# == Schema Information
#
# Table name: import_jobs
#
#  id                :integer          not null, primary key
#  original_filename :string(255)
#  temp_filename     :string(255)
#  starttime         :datetime
#  finishtime        :datetime
#  person_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe ImportJob, type: :model do
   it { should have_many(:import_step) }

end
