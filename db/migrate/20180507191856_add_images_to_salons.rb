class AddImagesToSalons < ActiveRecord::Migration[5.2]
  def change
    add_column :salons, :images, :string
  end
end
