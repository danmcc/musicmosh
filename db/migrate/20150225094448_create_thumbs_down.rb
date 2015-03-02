class CreateThumbsDown < ActiveRecord::Migration
  def change
    create_table :thumbs_downs do |t|
      t.references :user, index: true
      t.references :show, index: true

      t.timestamps
    end
  end
end
