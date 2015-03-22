class Report < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates :show, presence: true
  validates :user, presence: true

  validates_uniqueness_of :show_id, :scope => :user

  def show_button
    if self.new_record?
      '<button id="report-show" data-show-id="' + show.id.to_s + '" class="btn btn-danger">
			  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Report
			</button>'
    else
      '<button id="show-reported" data-show-id="' + show.id.to_s + '" class="btn btn-danger">
			  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Reported
			</button>'
    end
  end
end