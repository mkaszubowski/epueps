require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Epueps
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :pl

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    config.assets.precompile += %w( ckeditor/* )

    config.browserify_rails.commandline_options = [
        '-t [ coffeeify --extension .coffee ]', # coffeescript support
        '-t [ reactify --extension .jsx.coffee --extension .jsx]', # react/jsx support
        '--extension .coffee', # to be able to remove extension from require
    ]

    # config.browserify_rails.commandline_options = "-t reactify --extension=\".js.jsx\""

    config.active_record.raise_in_transactional_callbacks = true

    config.i18n.available_locales = [:en, :pl]
    config.i18n.default_locale = :pl

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => Rails.application.secrets['gmail_username'],
      :password             => Rails.application.secrets['gmail_password'],
      :authentication       => "plain",
      :enable_starttls_auto => true
    }
  end
end
