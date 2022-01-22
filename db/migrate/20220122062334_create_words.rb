class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :name, null: false
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
