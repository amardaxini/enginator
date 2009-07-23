= engine_generator

* http://github.com/amardaxini/enginator

== DESCRIPTION:

Engine Generator is Used for generating a Rails Engine
In this engine has separate Database which Does not relate with Main application database

== FEATURES/PROBLEMS:

While installing application as engine we have to copy several files 
After copy Engine has one single database but here engine has its own database
 
# sudo gem install amardaxini-engine_generator
# /script/generate engine engine_name sourcedir:pluggapleapplicationpath
# change user_name and password in database.yml
# rake db:create:all
# rake db:migrate
If database is other than mysql change database.yml
What it Does 
# It copies sourcepath/app folder to engine name/app
# Add self.connection :#{engine name}_dev to all model
# Removing application controller and added engine controller which inherits from main app controller 
# Remaining Application controller in heri from engine controller
# Copy routes.rb and paste into vendor/plugins/engine/config/routes.rb
# Copy migrate folder into vendor/plugins/engine/db/migrate 
# Making Significant change in migration file thwn paste into mainapp/db/migrate folder

