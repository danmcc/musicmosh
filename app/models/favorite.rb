class Favorite < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates :show, presence: true
  validates :user, presence: true

  validates_uniqueness_of :show_id, :scope => :user

end