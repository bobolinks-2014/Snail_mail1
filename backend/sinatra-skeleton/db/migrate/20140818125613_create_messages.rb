class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.text  :body
      t.datetime :time_received
      t.string  :from
      t.string :subject
    end
  end
end
