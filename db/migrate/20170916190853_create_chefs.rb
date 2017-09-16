class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
    	t.string :chefname, :email
    	t.timestamps
    end
  end
end
