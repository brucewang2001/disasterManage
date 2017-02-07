class MessagesController < ApplicationController
	before_action :set_event, :except => :destroy
	before_action :authenticate_user!
	def index
		redirect_to :controller => :messages, :action => :new
	end
	def new
		@message = @event.messages.new
	end
	def create
		@message = @event.messages.new(message_params)
		@message.creator = current_user.email
		if @message.save
			flash[:notice] = '新增成功'
			redirect_to event_path(@event)
		else
			render :new
		end
	end
	def show
		@message = Message.find(params[:id])
	end

	def edit
		@message = Message.find(params[:id])
	end
	
	def destroy
		#byebug
		@message = Message.find(params[:event_id])
		if(@message.creator != current_user.email)
			flash[:alert] = '你不是訊息創建者'
		else
			flash[:notice] = '訊息刪除成功'
			@message.destroy
		end
		redirect_to event_path(Event.find(params[:id]))
	end
private
	def set_event
		@event = Event.find(params[:event_id])
	end

	def message_params
		params.require(:message).permit(:title, :content)
	end
end
