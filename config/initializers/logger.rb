if Rails.env.production?
  Rails.logger = Le.new('5c703294-66e8-45db-aeba-1e8915b4c20c')
elsif Rails.env.development?
  Rails.logger = Le.new('b9259c12-1a1b-4453-a821-3c5eee10807e')
end