class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :city
      t.string :state, limit: 2
      t.string :country, limit: 2

      t.timestamps
    end
  end
end
