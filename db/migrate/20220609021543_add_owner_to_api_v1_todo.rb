class AddOwnerToApiV1Todo < ActiveRecord::Migration[6.1]
  def change
    add_column :api_v1_todos, :owner, :string
  end
end
