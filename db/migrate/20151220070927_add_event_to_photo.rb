class AddEventToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :event, index: true, foreign_key: true
  end
end
