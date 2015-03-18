class ThumbsDown < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates :show, presence: true
  validates :user, presence: true

  validates_uniqueness_of :show_id, :scope => :user

  alias :old_initialize :initialize
  def initialize(attributes = nil)
    old_initialize(attributes)

    favorite = Favorite.where( :user_id => self.user_id, :show_id => self.show_id).first
    unless favorite.nil?
      favorite.destroy
    end

  end

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