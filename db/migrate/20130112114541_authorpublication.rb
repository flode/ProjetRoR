class Authorpublication < ActiveRecord::Migration
  def change
    create_table :authors_publications, :id => false do |t|
      t.references :author, :publication
    end

    add_index :authors_publications, [:author_id, :publication_id]
  end

end
