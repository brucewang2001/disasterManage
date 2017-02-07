class EventsController < ApplicationController
before_action :authenticate_user!
	def index
		@events = Event.all.order(id: :asc).page(params[:page])
	end
	def new
		@event = Event.new
	end
	def create
		@event = Event.new(event_params)
		@event.creator = current_user.email
		@event.save

		redirect_to :action => :index
	end
	def show
		@event = Event.find(params[:id])
	end

	def edit
		@event = Event.find(params[:id])
	end
	def update
		@event = Event.find(params[:id])
		@event.update(event_params)

		redirect_to :action => :show, :id => @event
	end
	def destroy
		@event = Event.find(params[:id])
		if(@event.creator != current_user.email)
			flash[:alert] = '你不是事件創建者'
		else
			flash[:notice] = '事件刪除成功'
			@event.destroy
		end
		redirect_to :controller => :events, :action => :index
	end
	def patch
		redirect_to :controller => :events, :action => :index
	end

private

	def event_params
		params.require(:event).permit(:title, :description, :category)
	end
	
end
