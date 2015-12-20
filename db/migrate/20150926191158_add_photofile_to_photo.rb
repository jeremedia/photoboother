class AddPhotofileToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :photofile, :string
  end
end
