class EngineGenerator < Rails::Generator::NamedBase
  attr_accessor :plugin_path,:source_dir,:plugin_name,:db_name,:user_name,:password
  require 'fileutils'
  
  def initialize(runtime_args, runtime_options = {})
    super
    @plugin_name = runtime_args.first
    @db_name = ""
    @user_name = ""
    @password = ""
    @attributes = []
    @source_dir = ""
    runtime_args[1..-1].each do |arg|
      @attributes << arg
    end
    @attributes.flatten.uniq
   #Dynamic Addding database and username and password
    @attributes.each do |option|
      option_parameter = option.split(":")
      if option_parameter.first == "db"
        @db_name = option_parameter[1]
      elsif option_parameter.first == "sourcedir"
         @source_dir = option_parameter.last
       end
      option_parameter = []    
     end 
  

    if !@source_dir.blank?
      source_path = @source_dir+"/app"
      if !File.directory?(source_path)
        @source_dir = ""
       end 
    end   

    @plugin_path =  "vendor/plugins/#{plugin_name}"
    FileUtils.mkdir(@plugin_path)
    FileUtils.mkdir(@plugin_path+"/config")
    FileUtils.cp_r(@source_dir+'/app',@plugin_path+"/app")
    FileUtils.cp(@source_dir+'/config/routes.rb',@plugin_path+"/config")
    FileUtils.cp_r(@source_dir+'/db',@plugin_path+"/db")
  end

  def manifest
    record do |m|
      m.directory @plugin_path+"/lib"
      m.directory @plugin_path+"/tasks"
      m.directory @plugin_path+"/test"
      m.template 'README',         "#{plugin_path}/README"
      m.template 'MIT-LICENSE',    "#{plugin_path}/MIT-LICENSE"
      m.template 'Rakefile',       "#{plugin_path}/Rakefile"
      m.template 'init.rb',        "#{plugin_path}/init.rb"
      m.template 'install.rb',     "#{plugin_path}/install.rb"
      m.template 'uninstall.rb',   "#{plugin_path}/uninstall.rb"
      m.template 'plugin.rb',      "#{plugin_path}/lib/#{plugin_name}.rb"
      m.template 'tasks.rake',     "#{plugin_path}/tasks/#{plugin_name}_tasks.rake"
      m.template 'unit_test.rb',   "#{plugin_path}/test/#{plugin_name}_test.rb"
      m.template 'test_helper.rb', "#{plugin_path}/test/test_helper.rb"
      m.template 'my_db.yml',      "#{plugin_path}/config/my_db.yml"
     # m.template "load_config.rb", "config/initializers/load_#{file_name}_config.rb"
     # m.file     "my_db.yml",     "config/#{file_name}_config.yml"
    end
   end
   
   def constant_name
     file_name.underscore.upcase
   end
  
   def after_generate
     # `rake enginedb:create`
     #add filename =amar then add amar_dev to an all model  self.establish_connection :amar_dev 
     Dir.glob("#{plugin_path}/app/models/*.rb").each do |f|
       content = ""
       file = File.open(f,"r")
       file.each do |line|
         content += "#{line} " 
       end
       db_connection = "self.establish_connection :#{file_name}_dev"
       content.sub!(/ActiveRecord::Base\s{1}/,"ActiveRecord::Base\n #{db_connection} \n")
       #Find out ActiveRecord::Base and after this line place self.establish_connection :amar_dev 
       file = File.open(f,"w")
       file.write(content)
       file.close
     end
     # add to database yml amar_dev with data base amar_dev
     dbconfig = YAML::load(File.open('config/database.yml'))
     mydb = {"#{file_name}_dev"=>{"encoding"=>"utf8","reconnect"=>false,"adapter"=>"mysql","username"=>"root", "database"=>"#{file_name}_dev","pool"=>5, "password"=>"", "socket"=>"/var/run/mysqld/mysqld.sock"}}
     dbconfig =  dbconfig.merge(mydb)
     File.open('config/database.yml','w'){ |f| YAML.dump(dbconfig, f) }
    
     #added self.connection modelname.connection end
     Dir.glob("#{plugin_path}/db/migrate/*.rb").each do |f|
       content = ""
       file = File.open(f,"r")
       file.each do |line|
         content += "#{line} " 
       end
       mig_array = ["To", "From", "Create" ,"Remove"]
       model_name = ""
       mig_array.each do |m_a|
         reg_exp = %r{#{m_a}(.+)\s+<}
         model_name = reg_exp.match(content)[1] unless reg_exp.match(content).nil?
         if !model_name.blank?
           break
         end
      end
      migrate_connection =""
      if !model_name.blank?
        migrate_connection = "def self.connection
              #{model_name.singularize}.connection
              end"
        end
        if !model_name.blank?
          content.sub!(/ActiveRecord::Migration\s{1}/,"ActiveRecord::Migration\n #{migrate_connection} \n")
        end
        file = File.open(f,"w")
        file.write(content)
        file.close
      end
      #Added all migration to base migration      
      FileUtils.cp_r(@plugin_path+"/db/migrate/.",'db/migrate')
   end
   
   
end

