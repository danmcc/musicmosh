class ThumbsDownController < ApplicationController

  before_filter :authenticate_user!, :except => [:create]

  def index
    @thumbs_down = current_user.thumbs_down
                   .includes(:show => :artist)
                   .includes(:show => :venue)
                   .paginate(:page => params[:page], :per_page => 10)
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

    thumbs_down = ThumbsDown.new(
      user_id: current_user.id,
      show_id: params['show_id']
    )

    if thumbs_down.save
      output = {
        'success' => 1,
        'thumbs_down_id' => thumbs_down.id
      }.to_json
    else
      output = {'success' => 0}.to_json
    end

    respond_to do |format|
      format.json {
        render :json => output
      }
    end
  end

  def destroy
    thumbs_down = ThumbsDown.find(params[:id])

    if thumbs_down.destroy!
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