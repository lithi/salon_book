class RemoveImagesFromSalon < ActiveRecord::Migration[5.2]
  def change
    remove_column :salons, :image, :string
  end
end
