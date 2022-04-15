class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :task
      t.boolean :done
      t.date :due_by

      t.timestamps
    end
  end
end
