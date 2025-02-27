class RoomMessagesController < ApplicationController
  before_action :load_entities
  skip_before_action :verify_authenticity_token

  def create
    @room_message = RoomMessage.create user: current_user, room: @room, message: params.dig(:room_message, :message)
    RoomChannel.broadcast_to @room, @room_message
    # ActionCable.server.broadcast "room_#{@room}", message: params.dig(:room_message, :message), username: current_user
    if Rails.env.test?
      render json: @room_message.as_json(include: [:user]), status: :created
    end
  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end