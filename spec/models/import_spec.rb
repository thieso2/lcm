require 'rails_helper'

RSpec.describe Import, type: :model do
   it { should have_many(:importstep) }
end
