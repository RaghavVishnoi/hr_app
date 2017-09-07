class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def message(data)
    @message = Message.new(message: data['message'])
    if @message.save!
      ActionCable.server.broadcast "room_channel", 
        message_html: ApplicationController.renderer.render(partial: "general/message", locals: { msg: @message }), message_text: @message.message, m_link: @message.id
    end
  end
end
