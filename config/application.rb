require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Rubysystem
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.time_zone = 'Seoul'
    config.i18n.default_locale = :ko
  end
end
