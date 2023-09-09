class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    can :destroy, Post do |post|
      post.author == user || user.role == 'admin'
    end

    can :destroy, Comment do |comment|
      comment.author == user || user.admin?
    end
  end
end
