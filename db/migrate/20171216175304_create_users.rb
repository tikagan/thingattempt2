class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :company_name
      t.string :company_size
      t.string :phone_number
      t.string :password_digest

      t.timestamps
    end
  end
end
