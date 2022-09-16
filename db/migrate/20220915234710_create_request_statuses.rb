class CreateRequestStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :request_statuses do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
