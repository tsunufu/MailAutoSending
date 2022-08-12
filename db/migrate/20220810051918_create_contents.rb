class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.integer :group_id
    end
  end
end
