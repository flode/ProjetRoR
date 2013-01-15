class AddColumnToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :lab, :string
  end
end
