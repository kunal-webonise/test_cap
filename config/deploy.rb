# config valid only for current version of Capistrano


set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
set :application, "myapp"
set :repository, 'git@github.com:kunal-webonise/test_cap.git'
set :scm, :git
set :use_sudo, false
set :deploy_to, "/home/ubuntu/www/demo_app"

desc "check production task"
task :check_production do

if stage.to_s == "production"
puts " \n Are you REALLY sure you want to deploy to production?"
puts " \n Enter the password to continue\n "
password = STDIN.gets[0..7] rescue nil
if password != 'mypasswd'
puts "\n !!! WRONG PASSWORD !!!"
exit
end

end

end

task :bundle_install_karo do

  run  'echo "bundling" cd /home/ubuntu/www/demo_app/current && bundle install'
end

before "deploy", "check_production"
after 'deploy', 'bundle_install_karo'
