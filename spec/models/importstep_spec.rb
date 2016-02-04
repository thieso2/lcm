require 'rails_helper'

RSpec.describe Importstep, type: :model do
  it { should have_many(:importrows) }
end
