class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
      
    end
    # what is indexing
    # Indexing is a way of sorting a number of records on multiple fields. 
    # Creating an index on a field in a table creates another data structure which holds the field value,
    #  and pointer to the record it relates to. This index structure is then sorted, 
    # allowing Binary Searches to be performed on it.
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # includes a composite index that enforces uniqueness of pairs of (follower_id, followed_id)
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
