module ActiveRecord
  module Seed
    class Railtie < ::Rails::Railtie
      config.seed = ActiveRecord::Seed.config

      rake_tasks do
        load 'active_record/seed/databases.rake'
      end
    end
  end
end

ActiveSupport.on_load(:before_configuration) do
  ActiveRecord::Seed.configure do |config|
    config.models_dir = Rails.configuration.paths['app/models'].existent.first
    config.seeds_dir = Rails.root.join('db/data').to_s
    config.tables = []
  end
end
