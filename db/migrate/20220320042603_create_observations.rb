class CreateObservations < ActiveRecord::Migration[6.1]
  def change
    create_table :observations do |t|
      t.string :title
      t.string :body
      t.integer :result
      t.integer :visit_note_id
      
      t.timestamps
    end
  end
end
