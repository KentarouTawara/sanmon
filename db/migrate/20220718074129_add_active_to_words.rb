class AddActiveToWords < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :active, :boolean, null: false, default: true
  end
end
