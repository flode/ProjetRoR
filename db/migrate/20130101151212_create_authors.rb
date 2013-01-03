class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :surname
      t.string :forename
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
