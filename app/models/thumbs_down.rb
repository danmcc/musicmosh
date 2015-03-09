class ThumbsDown < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates :show, presence: true
  validates :user, presence: true

  validates_uniqueness_of :show_id, :scope => :user

  def show_button
    if self.new_record?
      '<button id="thumbs-down-show" data-show-id="' + show.id.to_s + '" class="btn btn-default">
        <i class="fa fa-thumbs-o-down show-thumbs-down"></i>
      </button>'
    else
      '<button id="thumbs-down-show" data-show-id="' + show.id.to_s + '" class="btn btn-dark">
          <i class="fa fa-thumbs-o-down show-thumbs-down"></i>
        </button>'
    end
  end
end