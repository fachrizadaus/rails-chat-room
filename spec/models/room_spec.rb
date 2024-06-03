require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should have_many(:room_messages).inverse_of(:room) }
end