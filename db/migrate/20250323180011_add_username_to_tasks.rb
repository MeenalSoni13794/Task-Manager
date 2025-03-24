class AddUsernameToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :username, :string
  end
end
