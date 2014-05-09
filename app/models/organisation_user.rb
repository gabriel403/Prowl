class OrganisationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :organisation
  belongs_to :access_level
  validates  :user, uniqueness: true
  # validates  :user, uniqueness: { scope: :organisation }
end
