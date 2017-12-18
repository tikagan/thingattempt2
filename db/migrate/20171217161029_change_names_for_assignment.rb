class ChangeNamesForAssignment < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :full_name, :string
  	add_column :users, :company_size, :integer
  	add_column :users, :phone_number, :string
  	remove_column :users,:first_name
  	remove_column :users,:last_name
  	remove_column :users,:role
  end
end
