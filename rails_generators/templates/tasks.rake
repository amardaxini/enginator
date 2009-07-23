require 'activerecord'
require 'yaml'
require 'ruby-debug'
namespace :enginedb do 
   
  desc 'Creates the databases defined in your config/my_db.yml (unless they already exist)' 
  task :create do  
    YAML::load(File.open('vendor/plugins/amar/config/my_db.yml')).each_value do |config| 
      begin 
        ActiveRecord::Base.establish_connection(config) 
        ActiveRecord::Base.connection 
      rescue 
        case config['adapter'] 
        when 'mysql' 
          @charset   =  'utf8' 
          @collation = 'utf8_general_ci' 
           ActiveRecord::Base.establish_connection(config.merge({'database' => nil})) 
          ActiveRecord::Base.connection.create_database(config['database'], {:charset => @charset, :collation => @collation}) 
          ActiveRecord::Base.establish_connection(config) 
        when 'postgresql' 
          `createdb "#{config['database']}" -E utf8`   
        end 
      end 
    end 
  
  end 
    desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
    task :migrate do
      ActiveRecord::Migrator.migrate("db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
     # Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
  end
end   
