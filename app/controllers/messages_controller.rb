class MessagesController < ApplicationController
  def index
    @Message = Message.new
    @room = Room.find(params[:room_id])
    @messages = room.messages.Include(:user)

  end

  def carate
    @room = Room.find(params[:room_id])
    @message = @room.message.new(message_paramas)
     if @message.save
      redirect_to room_messasges_new_path(@room)
     else
      @messages = @room.messages.Include(:user)
      render :index 
  end

  private

  def message_paramas
   params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
