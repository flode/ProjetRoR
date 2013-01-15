class AddColumnToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :type, :string
    add_column :publications, :publication, :string
    add_column :publications, :month, :int
    add_column :publications, :notes, :string
  end
end
