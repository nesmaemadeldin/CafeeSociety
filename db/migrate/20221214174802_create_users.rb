class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :access_token
      t.integer :expires_in
      t.string :scope
      t.string :token_type

      t.timestamps
    end
  end
end
