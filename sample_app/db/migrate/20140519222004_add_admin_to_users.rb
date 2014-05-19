class AddAdminToUsers < ActiveRecord::Migration
  def change
    # Without the default: false argument, admin will be nil by default, which is still false,
    # so this step is not strictly necessary. It is more explicit, though, 
    # and communicates our intentions more clearly both to Rails and to readers of our code.
    add_column :users, :admin, :boolean, default: false
  end
end
