class AddInheritToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :nn, :string
  end
end
