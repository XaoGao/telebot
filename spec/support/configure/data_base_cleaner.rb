RSpec.configure do |config|
  config.before do
    DatabaseCleaner[:sequel].strategy = :transaction
  end

  config.before do
    DatabaseCleaner[:sequel].start
  end

  config.after do
    DatabaseCleaner[:sequel].clean
  end
end
