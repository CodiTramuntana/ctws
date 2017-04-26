class CreateCtwsMinAppVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :ctws_min_app_versions do |t|
      t.string :codename
      t.text :description
      t.string :platform
      t.string :min_version
      t.string :store_uri

      t.timestamps
    end
  end
end
