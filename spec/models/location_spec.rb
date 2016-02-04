# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  city       :string           not null
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Location, :type => :model do
  subject { FactoryGirl.create(:location) }

  # it { should belong_to(:event_type) }
  it {  should have_db_column(:code) }

end
