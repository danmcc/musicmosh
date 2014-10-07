class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.date :date
      t.time :time
      t.references :artist, index: true
      t.references :venue, index: true

      t.timestamps
    end
  end
end
