class CreateRandomWords < ActiveRecord::Migration[7.0]
  def change
    create_table :random_words do |t|
      t.references :work, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true

      t.timestamps
    end
  end
end
