class Favorite < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates :show, presence: true
  validates :user, presence: true

  validates_uniqueness_of :show_id, :scope => :user

  def show_button
    if self.new_record?
      '<button id="add-show-to-favorites" data-show-id="' + show.id.to_s + '" class="btn btn-default">
			  <span class="glyphicon glyphicon-star" aria-hidden="true"></span> Favorite
			</button>'
    else
      '<button id="remove-show-from-favorites" data-show-id="' + show.id.to_s + '" data-favorite-id="' + self.id.to_s + '" class="btn btn-primary">
          <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Favorited
        </button>'
    end
  end
end