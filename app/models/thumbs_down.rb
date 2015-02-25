class ThumbsDown < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates :show, presence: true
  validates :user, presence: true

  validates_uniqueness_of :show_id, :scope => :user

  def show_button
    if self.new_record?
      '<button class="btn btn-dark">
        <i class="fa fa-thumbs-o-down show-thumbs-down"></i>
      </button>'
    else
      '<button class="btn btn-primary">
          <i class="fa fa-thumbs-o-down show-thumbs-down"></i>
        </button>'
    end
  end
end