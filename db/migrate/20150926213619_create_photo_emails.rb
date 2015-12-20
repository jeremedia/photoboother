class CreatePhotoEmails < ActiveRecord::Migration
  def change
    create_table :photo_emails do |t|
      t.integer :photo_id
      t.string :email

      t.timestamps null: false
    end
  end
end
