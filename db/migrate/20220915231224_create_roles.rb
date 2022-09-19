class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :code
      t.text :description

      t.timestamps
    end
  end
end
