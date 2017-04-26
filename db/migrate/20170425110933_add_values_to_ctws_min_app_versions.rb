class AddValuesToCtwsMinAppVersions < ActiveRecord::Migration[5.0]
  def up
    min_app_version_ios = Ctws::MinAppVersion.create!({
      codename: "First Release", 
      description: "You need to update your app. You will be redirected to the corresponding store",
      platform: "ios",
      min_version: "0.0.1",
      store_uri: "https://itunes.apple.com/"
    })
    
    min_app_version_android = Ctws::MinAppVersion.create!({
      codename: "First Release", 
      description: "You need to update your app. You will be redirected to the corresponding store",
      platform: "android",
      min_version: "0.0.1",
      store_uri: "https://play.google.com"
    })
  end

  def down
    min_app_version_ios = Ctws::MinAppVersion.find_by_min_version( "0.0.1" )
    min_app_version_ios.destroy
    min_app_version_android = Ctws::MinAppVersion.find_by_min_version( "0.0.1" )
    min_app_version_android.destroy       
  end
end
