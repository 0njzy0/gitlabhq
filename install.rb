root_path = File.expand_path(File.dirname(__FILE__))
require File.join(root_path, "lib", "color")
include Color

# 
# ruby ./update.rb development # or test or production (default)
#
envs = ["production", "test", "development"]
env = if envs.include?(ARGV[0])
        ARGV[0]
      else
        "production"
      end

puts green " == Install for ENV=#{env} ..."

# pull from github
`git pull origin 1x`

# bundle install
if env == "production"
`bundle install --without development test`
else
`bundle install`
end

# migrate db
`bundle exec rake db:setup RAILS_ENV=#{env}`
`bundle exec rake db:seed_fu RAILS_ENV=#{env}`


puts green " == Done! Now you can start server"
