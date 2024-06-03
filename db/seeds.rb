# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'

  # MySQL and PostgreSQL
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")

  # SQLite
  # ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
end
p "All data truncated, seeding user data"

if ENV['VERSION'].present?
  seed_files = Dir[File.join(File.dirname(__FILE__), 'seeds', "*#{ENV['VERSION']}*.rb")]
  raise "No seed files found matching '#{ENV['VERSION']}'" if seed_files.empty?
else
  seed_files = Dir[File.join(File.dirname(__FILE__), 'seeds', '*.rb')]
end

seed_files.sort_by{|f| File.basename(f).to_i}.each do |file|
  require File.join(File.dirname(__FILE__), 'seeds', File.basename(file, File.extname(file)))
end