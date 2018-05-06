class CreateSalonServices < ActiveRecord::Migration[5.2]
  def change
    create_table :salon_services do |t|
      t.integer :salon_id
      t.integer :service_id

      t.timestamps
    end
    add_index :salon_services, :salon_id
    add_index :salon_services, :service_id
    add_index :salon_services, [:salon_id, :service_id], unique: true

  end
end
