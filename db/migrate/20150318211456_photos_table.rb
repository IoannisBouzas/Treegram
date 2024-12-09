class PhotosTable < ActiveRecord::Migration
  def change
    create_table :photos do |photons|
      photons.column :title,   :string
      photons.column :user_id, :integer
      photons.column :caption, :string
      photons.timestamps
    end
  end
end
