class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :item
      t.references :friend, index: true

      t.timestamps
    end
  end
end
