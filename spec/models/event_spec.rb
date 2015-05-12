# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  group_type_id :integer
#  title         :string
#  location      :string
#  startdate     :date
#  enddate       :date
#  baseprice     :decimal(8, 2)
#  group_state   :integer          default("0"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
