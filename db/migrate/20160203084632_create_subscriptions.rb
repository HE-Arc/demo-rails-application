class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :subscriptions, :deleted_at
  end
end
