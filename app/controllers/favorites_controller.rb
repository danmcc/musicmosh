class FavoritesController < ApplicationController

	def index

	end

	def create

    if current_user.nil?
      output = {'login' => 0}

      return respond_to do |format|
        format.json {
          render :json => output, :status => 401
        }
      end

    end

    favorite = Favorite.new(
      user_id: current_user.id,
      show_id: params['show_id']
    )

    if favorite.save
      output = {'success' => 1}.to_json
    else
      output = {'success' => 0}.to_json
    end

		respond_to do |format|
			format.json {
				render :json => output
			}
		end
	end


end