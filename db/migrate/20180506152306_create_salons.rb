class CreateSalons < ActiveRecord::Migration[5.2]
  def change
    create_table :salons do |t|
      t.string :name
      t.integer :tel
      t.string :address
      t.string :image
      t.integer :user_id


      t.timestamps
    end
  end
end
