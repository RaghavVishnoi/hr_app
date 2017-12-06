class CreateResultReceivers < ActiveRecord::Migration[5.0]
  def change
    create_table :result_receivers do |t|
    	t.integer :exam_id
    	t.integer :receiver_id
        t.timestamps
    end
    add_foreign_key :result_receivers,:employees,column: :receiver_id
  end
end
