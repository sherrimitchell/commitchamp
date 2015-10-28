class CreateOrgs < ActiveRecord::Migration
  def up
    create_table :orgs do |t|
      t.string :name
    end
  end

  def down
    drop_table :orgs
  end
end