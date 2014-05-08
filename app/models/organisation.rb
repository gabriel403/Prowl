class Organisation < ActiveRecord::Base
  has_many  :apps
  has_many  :servers
  has_many  :organisation_users
  has_many  :users, through: :organisation_users
  validates :name,  presence: true
  validates :access_code,  presence: true, uniqueness: true
end
