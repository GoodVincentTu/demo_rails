class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.string :username
      
      # reset password
      t.string :reset_token_digest
      t.datetime :reset_token_sent_at
    end

    add_index :users, :email, :unique => true
    add_index :users, :reset_token_digest, :unique => true
  end
end
