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

	private

	def request_params
		params.require(:artist_request).permit(:message, :url)
			.merge(user_id: current_user.id)
	end

end
