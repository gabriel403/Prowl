class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    cannot :manage,   :all
    can    :read,     User
    can    :manage,   Organisation, :organisation_users => { :user => { :id => user.id }, :access_level => { :value => 'admin', :access_type => 'org_access' } }
    can    :read,     Organisation, :organisation_users => { :user => { :id => user.id }, :access_level => { :value => 'user',  :access_type => 'org_access' } }

    if user.organisations.first
      can    :manage, Server,       :organisation_id => user.organisations.first.id, :organisation => { :organisation_users => { :user => { :id => user.id }, :access_level => { :value => 'admin', :access_type => 'org_access' } } }
      can    :read,   Server,       :organisation_id => user.organisations.first.id, :organisation => { :organisation_users => { :user => { :id => user.id }, :access_level => { :value => 'user', :access_type => 'org_access' } } }
      can    :read,   App,          :organisation_id => user.organisations.first.id, :organisation => { :organisation_users => { :user => { :id => user.id }, :access_level => { :value => 'user', :access_type => 'org_access' } } }
      can    :manage, Env,          :env_users => { :user => { :id => user.id }, :access_level => { :value => 'admin', :access_type => 'env_access' } }
      can    :read,   Env,          :env_users => { :user => { :id => user.id }, :access_level => { :value => 'user', :access_type => 'env_access' } }
      can    :read,   Deploy,       :env => { :env_users => { :user => { :id => user.id }, :access_level => { :value => 'user', :access_type => 'env_access' } } }
    else
      can    :create, Organisation
    end

    # access_levels
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
