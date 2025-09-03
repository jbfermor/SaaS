class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest (no logueado)

    # --- Admin global ---
    if user.role&.name == "admin"
      can :manage, :all

    # --- Subadmin global ---
    elsif user.role&.name == "subadmin"
      can :create, User, role: { name: ["visitor", "insider"] }
      can :read, User
      can :update, User
      cannot :destroy, User

    # --- Insider (puede tener AccountRole) ---
    elsif user.role&.name == "insider"
      if user.account_roles.exists?(name: "super")
        can :manage, Account, creator_id: user.id
        can :create, User, role: { name: "worker" }
        can :manage, AccountRole, account: { creator_id: user.id }
      else
        can :read, Account, account_roles: { user_id: user.id }
        can :read, User, id: user.id
      end

    # --- Visitor ---
    elsif user.role&.name == "visitor"
      can :read, :home
    end
  end
end
