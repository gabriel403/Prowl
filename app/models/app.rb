class App < ActiveRecord::Base
  belongs_to :organisation
  has_many :envs
  validates :name,          presence: true
  validates :organisation,  presence: true
end
