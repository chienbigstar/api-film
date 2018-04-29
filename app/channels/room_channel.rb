class RoomChannel < ApplicationCable::Channel
  def subscribed
    user = self.current_user
    ip = self.ip
    if ip != user.ip
       ActionCable.server.broadcast "room_channel_#{user.id}_#{user.ip}", message: 'hello'
    end
    stream_from "room_channel_#{user.id}_#{ip}"
  end

  def unsubscribed
  end

  def speak(data)
  end
end