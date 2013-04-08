require 'active_record/base'
require 'active_support/core_ext/string/inflections'

namespace :db do
  namespace :seed do
    task :prepare => :environment do
      abort('ERROR: must set config `tables`') if ActiveRecord::Seed.config.tables.empty?

      models_dir = ActiveRecord::Seed.config.models_dir
      Dir.glob("#{models_dir}/**/*.rb").sort.each do |file|
        require_dependency file.sub(/\A#{Regexp.escape(models_dir)}\/(.*)\.rb\Z/, '\1')
      end
    end

    desc 'Dump all table data to seed csv files'
    task :dump => :prepare do
      seeds_dir = ActiveRecord::Seed.config.seeds_dir
      Dir.mkdir(seeds_dir) unless File.directory?(seeds_dir)

      ActiveRecord::Base.__send__(:include, ActiveRecord::Seed::Converter)

      ActiveRecord::Base.descendants.each do |model|
        next unless model.superclass == ActiveRecord::Base
        next unless ActiveRecord::Seed.target?(model.table_name)

        File.write("#{seeds_dir}/#{model.table_name}.csv", model.dump_to_csv)
        puts "#{model.table_name} dumped."
      end
    end

    desc 'Load all table data from seed csv files'
    task :load => :prepare do
      ActiveRecord::Base.transaction do
        Dir.glob("#{ActiveRecord::Seed.config.seeds_dir}/*.csv").each do |csv|
          table = File::basename(csv, '.csv')
          next unless ActiveRecord::Seed.target?(table)
          next unless model = table.classify.safe_constantize

          CSV.open(csv, headers: true, header_converters: :symbol).each do |row|
            attrs = row.to_hash.reject{|k, v| v.nil? || v.empty? }
            model.where(attrs).first_or_create!({}, without_protection: true)
          end
          puts "#{table} loaded."
        end
      end
    end
  end
end
