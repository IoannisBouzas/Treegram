class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string 'text_comment'
      t.references :photo, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    # better query handling
    add_index :comments, [:photo_id, :created_at]
    add_index :comments, [:user_id, :created_at]

  end
end



