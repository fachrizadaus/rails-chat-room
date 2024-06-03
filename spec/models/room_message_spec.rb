require 'rails_helper'

RSpec.describe RoomMessage, type: :model do
  it { should belong_to(:room).inverse_of(:room_messages) }
  it { should belong_to(:user) }

  describe '#as_json' do
    let(:user) { create(:user, username: 'testuser') }
    let(:room_message) { create(:room_message, user: user) }

    it 'includes the username' do
      expect(room_message.as_json['username']).to eq('testuser')
    end
  end
end
