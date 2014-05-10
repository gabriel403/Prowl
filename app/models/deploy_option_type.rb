class DeployOptionType < ActiveRecord::Base
  validates :name, presence: true
end
