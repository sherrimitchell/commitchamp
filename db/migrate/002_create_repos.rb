class CreateRepos < ActiveRecord::Migration
  def up
    create_table :repos do |t|
      t.string :name
      t.string :owner
      t.integer :org_id
    end
  end

  def down
    drop_table :repos
  end
end