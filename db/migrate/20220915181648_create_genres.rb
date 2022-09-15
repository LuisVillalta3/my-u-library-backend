class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.string :name, unique: true
      t.text :description, default: "No description provided."

      t.timestamps
    end
  end
end
