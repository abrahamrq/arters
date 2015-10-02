class RequestsController < ApplicationController

	def new_request
		@request = ArtistRequest.new if !current_user.artist_requests.pending.any?
	end

	def send_request
		@request = ArtistRequest.new(request_params)
		if @request.save
			flash[:success] = 'Your request has been sended, ' \
												'please wait until an admin accept or reject it'
			redirect_to root_path
		else
			render :new_request
		end
	end

	def index
		@requests = ArtistRequest.pending
	end

	def change_status
		@artist_request = ArtistRequest.find(params[:artist_request_id])
		@artist_request.send("#{params[:status]}!")
		@artist_request.authorize_user
		render json: @artist_request, status: 200
	end

	private

	def request_params
		params.require(:artist_request).permit(:message, :url)
			.merge(user_id: current_user.id)
	end

end
