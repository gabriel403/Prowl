redis_config = YAML.load_file("#{Rails.root}/config/redis.yml") 
Resque.redis = Redis.new(redis_config[Rails.env])