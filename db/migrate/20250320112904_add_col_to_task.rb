class AddColToTask < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :email, :string
  end
end
