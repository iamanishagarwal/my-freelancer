# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role?('admin')
      can :manage, :all
    elsif user.role?('freelancer')
      can :read, :all
      can %i[create new], Freelancer
      can %i[edit update], Freelancer, user_id: user.id
    elsif user.role?('client')
      can :read, :all
      can %i[create new], Client
      can %i[edit update], Client, user_id: user.id
      can %i[new create], Job
      can %i[edit update delete], Job, user_id: user.id
    else
      can :read, :all
    end

    can %i[create update delete], User, id: user.id unless user.role?(:admin)
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
