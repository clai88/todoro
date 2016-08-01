source "https://rubygems.org"

ruby '2.3.1'

gem "sinatra"
gem "activerecord", "~> 4.2"
gem "rake"
gem "better_errors"
gem "binding_of_caller"

group :test, :development do
  gem "pry"
  gem "simplecov", require: false
  gem "minitest"
  gem "rack-test"
  gem "sqlite3"
end

group :production do
  gem "pg"
end
