namespace :db do
  desc "Loads a schema.rb file into the database and then loads the initial database fixtures."
  task :bootstrap => ['db:schema:load', 'db:bootstrap:load']

  namespace :bootstrap do
    desc "Load initial database fixtures (in db/bootstrap/*.yml) into the current environment's database. Load specific fixtures using FIXTURES=x,y"
    task :load => :environment do
      require 'active_record/fixtures'
      ActiveRecord::Base.establish_connection(Rails.env.to_sym)
      (ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : Dir.glob(File.join(Rails.root.to_s, 'db', 'bootstrap', '*.{yml,csv}'))).each do |fixture_file|
        AcitveRecord::TestFixtures.create_fixtures('db/bootstrap', File.basename(fixture_file, '.*'))
      end
    end
  end
end
