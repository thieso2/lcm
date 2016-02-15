require 'rails_helper'

RSpec.describe ImportStep, type: :model do
  it { should have_many(:import_row) }
end
