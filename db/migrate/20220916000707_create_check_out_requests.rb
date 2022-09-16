class CreateCheckOutRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :check_out_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.references :request_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
