class CreateTaskMigration < ActiveRecord::Migration
  def change
    create_table(:tasks) do |t|
      t.string :name
      t.boolean :completed
      t.datetime :due_on
      t.integer :list_id
    end
  end
end
