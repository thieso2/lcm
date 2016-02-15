require 'rails_helper'

RSpec.describe ImportRow, type: :model do
  it { should belong_to(:import_step) }
end
