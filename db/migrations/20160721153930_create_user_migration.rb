class CreateUserMigration < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :name
      t.integer :user_id
      t.datetime :picked_at
    end
  end
end
