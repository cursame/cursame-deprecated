class ChatsController < ApplicationController 
  def create 
    @chats = Chat.all 
    @chat = Chat.new(params[:chat])
             @chat.user=current_user
             @chat.user_name=current_user.name
             @chat.time=Time.now
             @course=@chat.course
  respond_to do |format|
    if @chat.save
       format.json {redirect_to :back , :notice => I18n.t('flash.msg_send') }
       format.js    
    else
       format.js {render :action => "rollback.js.erb"}
    end
   end
  end

  
end
