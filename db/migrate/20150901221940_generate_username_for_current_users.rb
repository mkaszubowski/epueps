class GenerateUsernameForCurrentUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      next unless user.username.blank?

      user.username = user.email.gsub(/\@.*/, '')
      user.save
    end
  end
end
