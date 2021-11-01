# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'active_record'
require 'fileutils'

RuboCop::RakeTask.new

task default: :rubocop

namespace :db do
  environment = ENV.fetch('TSC_ENV') { 'development' }
  database = ENV.fetch('TSC_DATABASE') { "tsc-#{environment}.sqlite3" }
  database = File.join(Dir.pwd, 'lib', 'tsc', 'db', database)

  desc 'Create the database'
  task :create do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: database)
    puts 'Database created.'
  end

  desc 'Migrate the database'
  task :migrate do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: database)
    ActiveRecord::MigrationContext.new('lib/tsc/db/migrate/', ActiveRecord::SchemaMigration).migrate
    Rake::Task['db:schema'].invoke
    puts 'Database migrated.'
  end

  desc 'Drop the database'
  task :drop do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: database)
    FileUtils.rm(database)
    puts 'Database deleted.'
  end

  desc 'Reset the database'
  task reset: %i[drop create migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: database)
    require 'active_record/schema_dumper'
    filename = 'lib/tsc/db/schema.rb'
    File.open(filename, 'w:utf-8') do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end
end

namespace :g do
  desc 'Generate migration'
  task :migration do
    name = ARGV[1] || raise('Specify name: rake g:migration your_migration')
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    path = File.expand_path("../lib/tsc/db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split('_').map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<~EOF
        class #{migration_class} < ActiveRecord::Migration[6.1]
          def change
          end
        end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
