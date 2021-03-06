class EmailsUniquenessPerType < ActiveRecord::Migration[5.2]
  def change
    safety_assured do
      remove_index :users, column: :email, name: :index_users_on_email
      add_index :users, %i[type email], unique: true
    end
  end
end
