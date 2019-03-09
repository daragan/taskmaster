class CreateProects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :about
      t.string :task_id
      t.string :user_id
    end
  end
end
