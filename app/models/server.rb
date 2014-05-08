class Server < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :authentication_type
  validates  :organisation,  presence: true
  validates  :name,  presence: true
  validates  :host,  presence: true
  validates  :username,  presence: true
  validates  :authentication_type,  presence: true
  validates  :authentication,  presence: true
end
