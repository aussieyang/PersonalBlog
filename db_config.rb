require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'personalpage'
}

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || options)

#ENV stands for environment - connects to database; syntax for Heroku
