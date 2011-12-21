class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :parent_id
      t.integer :articles_count, :default => 0
      t.integer :users_count, :default => 0
      t.string :info, :limit => 200
      t.string :preface, :limit => 500

      t.timestamps
    end
  end
end
