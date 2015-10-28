class CreateContributions < ActiveRecord::Migration
  def up
    create_join_table :users, :repos, table_name: :contributions do |t|
      t.integer :user_id
      t.integer :repo_id
      t.string :additions
      t.string :deletions
      t.string :commits
    end
  end

  def down
    drop_table :contributions
  end
end