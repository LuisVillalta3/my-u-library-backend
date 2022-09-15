class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, unique: true
      t.text :description, null: true, default: 'No description provided'
      t.references :author, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.date :published_date, default: Date.today
      t.integer :in_stock, default: 0, min: 0
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
