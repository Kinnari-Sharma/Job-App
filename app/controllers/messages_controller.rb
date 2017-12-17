class MessagesController < ApplicationController
	before_action do
		@conversation = Conversation.find(params[:conversation_id])
	end
	before_action :logged_in_user
	before_action :authorized_user, only: :index

	def index
		@messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
  
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
  
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true;
      end
    end

    @message = @conversation.messages.build
	end

	def new
		@message = @conversation.messages.build
	end

	def create
		@message = @conversation.messages.build(message_params)
		if @message.save
			redirect_to conversation_messages_path(@conversation)
		end
	end

	private
	  def message_params
	  	params.require(:message).permit(:body, :user_id)
	  end

	  def logged_in_user
	  	unless logged_in?
	  		flash[:warning] = "Please log in!"
	  		redirect_to login_path
	  	end
	  end

	  def authorized_user
	  	unless @conversation.sender_id == current_user.id || @conversation.recipent_id == current_user.id
	  		redirect_to conversations_path(current_user), flash: { warning: "Unauthorized Access" }
	  	end
	  end

end
