rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

redis_config = YAML.load_file("#{rails_root}/config/redis.yml") 
Resque.redis = Redis.new(redis_config[Rails.env])