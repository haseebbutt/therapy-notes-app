class CreateVisitNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :visit_notes do |t|
      t.string :title
      t.text :description
      t.integer :patient_id
      
      t.timestamps
    end
  end
end
