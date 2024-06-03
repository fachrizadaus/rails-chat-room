require 'rails_helper'

RSpec.describe RoomMessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:room) { create(:room) }
  let(:valid_attributes) { { message: 'Hello, world!', room_id: room.id, user_id: user.id } }
  let(:invalid_attributes) { { message: '', room_id: room.id, user_id: user.id } }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new RoomMessage' do
        expect {
          post :create, params: { room_message: valid_attributes }
        }.to change(RoomMessage, :count).by(1)
      end

      it 'returns a created status with the message as JSON' do
        post :create, params: { room_message: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end