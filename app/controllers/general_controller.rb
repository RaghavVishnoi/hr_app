class GeneralController < ApplicationController
  layout 'user', except: [:new_message, :send_message, :show_message, :delete_message]

  skip_before_filter :authenticate_employee!
  def index
  end

  def about
  end

  def contact
  end

  def new_message
    @message = Message.new
    @messages = Message.all.order("id desc")
  end

  def send_message
    @message = Message.new(params.require(:message).permit!)
    # if @message.save
    # broadcast_msg "/messages/fired", @message
    # end
    redirect_to general_new_message_path
  end

  def show_message
    @message = Message.find(params[:m_id])
  end

  def delete_message
    @message = Message.find(params[:m_id]).delete
    redirect_to general_new_message_path
  end

end
