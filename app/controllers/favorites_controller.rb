class FavoritesController < ApplicationController

	def index

	end

	def create
		respond_to do |format|
			format.html {render text: "Your data was sucessfully loaded. Thanks"}
			format.json {
				render text: params.to_json
			}
		end
	end


end