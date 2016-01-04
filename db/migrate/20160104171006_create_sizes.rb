class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
