class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :formTitle
      t.string :formDescription
      t.string :date

      t.timestamps
    end
  end
end
