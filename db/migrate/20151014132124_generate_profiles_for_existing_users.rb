class GenerateProfilesForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.send(:generate_profile)
    end
  end
end
