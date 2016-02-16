# == Schema Information
#
# Table name: import_rows
#
#  id             :integer          not null, primary key
#  import_step_id :integer
#  row            :integer
#  rawdata        :text(65535)
#  importdata     :text(65535)
#  conflictdata   :text(65535)
#  state          :integer
#  message        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe ImportRow, type: :model do
  it { should belong_to(:import_step) }
end
