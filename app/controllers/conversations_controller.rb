class ConversationsController < ApplicationController
  before_action :logged_in_user

	def index
		@users = User.all
		@conversations = Conversation.all
	end

	def create
		if Conversation.between(params[:sender_id], params[:recipent_id]).present?
			@conversation = Conversation.between(params[:sender_id], params[:recipent_id]).first
		else
			@conversation = Conversation.create!(conversation_params)
		end
		redirect_to conversation_messages_path(@conversation)
	end

	private
	  def conversation_params
	  	params.permit(:sender_id, :recipent_id)
	  end

	  def logged_in_user
	  	unless logged_in?
	  		redirect_to login_path, flash: { warning: "Please log in!" }
	  	end
	  end

end
