class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
    	t.string :city
    	t.string :item
    	t.string :count
    end
  end
end
