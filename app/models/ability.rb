class Ability
  include CanCan::Ability

  def initialize(user)
    user
    cannot :manage, :all
    can    :read,   User
    can    :read,   Organisation,         :organisation_users => { :user => user, :access_level => { :value => 'user',  :access_type => 'org_access' } }

    if user.organisations.first
      can    :manage, Organisation,         :organisation_users => { :user => user, :access_level => { :value => 'admin', :access_type => 'org_access' } }

      can    :read,   Server,               :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'user', :access_type => 'org_access' } } }
      can    :manage, Server,               :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'admin', :access_type => 'org_access' } } }

      can    :read,   App,                  :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'user', :access_type => 'org_access' } } }
      can    :manage, App,                  :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'admin', :access_type => 'org_access' } } }

      can    :read,   Env,                  :env_users => { :user => user, :access_level => { :value => 'user', :access_type => 'env_access' } }
      can    :manage, Env,                  :app => { :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'admin', :access_type => 'org_access' } } } }
      can    :manage, Env,                  :env_users => { :user => user, :access_level => { :value => 'admin', :access_type => 'env_access' } }

      can    :manage, DeployStep,           :env => { :app => { :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'admin',  :access_type => 'org_access' } } } } }

      can    :read,   Deploy,               :env => { :env_users => { :user => user, :access_level => { :value => 'user', :access_type => 'env_access' } } }

      can    :manage, OrganisationUser,     :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'admin',  :access_type => 'org_access' } } }

      can    :manage, EnvUser,              :env => { :app => { :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'admin',  :access_type => 'org_access' } } } } }
      can    :manage, EnvServer,            :env => { :app => { :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'admin',  :access_type => 'org_access' } } } } }

      can    :manage, Deploy,               :env => { :app => { :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :value => 'admin',  :access_type => 'org_access' } } } } }
      can    :manage, DeployOption,         :deploy => { :env => { :app => { :organisation => user.organisations.first, :organisation => { :organisation_users => { :user => user, :access_level => { :access_type => 'org_access' } } } } } }
      can    :read,   DeployOption

      can    :read,   DeployStepType
      can    :read,   DeployStepTypeOption
      can    :read,   AccessLevel
      can    :read,   DeployOptionType
      can    :read,   AuthenticationType
    else
      can    :create, Organisation
    end

    # access_levels
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
