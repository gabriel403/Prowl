class AccessLevel < ActiveRecord::Base
  validates :name,  presence: true
  validates :access_type,  presence: true
  validates :value,        presence: true
end
