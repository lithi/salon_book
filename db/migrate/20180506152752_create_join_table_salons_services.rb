class CreateJoinTableSalonsServices < ActiveRecord::Migration[5.2]
  def change
    create_join_table :salons, :services do |t|
      # t.index [:salon_id, :service_id]
      # t.index [:service_id, :salon_id]
    end
  end
end
