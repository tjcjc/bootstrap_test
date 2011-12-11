require 'bundler/capistrano'
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.2'        # Or whatever env you want it to run in.
set :application, "13nian"
set :repository,  "git@13nian.com:/opt/git/compass.git"
set :use_sudo, false

#set :template_dir, "foo/bar"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "dog"
set :scm_passphrase, "dogdogdoggg"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/13nian"
server "oo-oo.me", :app, :web, :db, :primary => true

unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end


  namespace :passenger do

    desc <<-DESC
      Restarts your application. \
      This works by creating an empty `restart.txt` file in the `tmp` folder
      as requested by Passenger server.
    DESC
    task :restart, :roles => :app, :except => { :no_release => true } do
      run "touch #{current_path}/tmp/restart.txt"
    end

    desc <<-DESC
      Starts the application servers. \
      Please note that this task is not supported by Passenger server.
    DESC
    task :start, :roles => :app do
      logger.info ":start task not supported by Passenger server"
    end

    desc <<-DESC
      Stops the application servers. \
      Please note that this task is not supported by Passenger server.
    DESC
    task :stop, :roles => :app do
      logger.info ":stop task not supported by Passenger server"
    end

  end

  namespace :deploy do

    desc <<-DESC
      Restarts your application. \
      Overwrites default :restart task for Passenger server.
    DESC
    task :restart, :roles => :app, :except => { :no_release => true } do
      passenger.restart
    end

    desc <<-DESC
      Starts the application servers. \
      Overwrites default :start task for Passenger server.
    DESC
    task :start, :roles => :app do
      passenger.start
    end

    desc <<-DESC
      Stops the application servers. \
      Overwrites default :start task for Passenger server.
    DESC
    task :stop, :roles => :app do
      passenger.stop
    end

  end

  namespace :db do

    desc <<-DESC
      Creates the database.yml configuration file in shared path.

      By default, this task uses a template unless a template
      called database.yml.erb is found either is :template_dir
      or /config/deploy folders. The default template matches
      the template for config/database.yml file shipped with Rails.

      When this recipe is loaded, db:setup is automatically configured
      to be invoked after deploy:setup. You can skip this task setting
      the variable :skip_db_setup to true. This is especially useful
      if you are using this recipe in combination with
      capistrano-ext/multistaging to avoid multiple db:setup calls
      when running deploy:setup for all stages one by one.
    DESC
    task :setup, :except => { :no_release => true } do

      default_template = <<-EOF
      base: &base
        adapter: sqlite3
        timeout: 5000
      development:
        database: #{shared_path}/db/development.sqlite3
        <<: *base
      test:
        database: #{shared_path}/db/test.sqlite3
        <<: *base
      production:
        database: #{shared_path}/db/production.sqlite3
        <<: *base
      EOF

      location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
      template = File.file?(location) ? File.read(location) : default_template

      config = ERB.new(template)

      run "mkdir -p #{shared_path}/db"
      run "mkdir -p #{shared_path}/config"
      put config.result(binding), "#{shared_path}/config/database.yml"
    end

    desc <<-DESC
      [internal] Updates the symlink for database.yml file to the just deployed release.
    DESC
    task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end

  end

  after "deploy:setup",           "db:setup"   unless fetch(:skip_db_setup, false)
  after "deploy:finalize_update", "db:symlink"


# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
