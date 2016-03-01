class UserPolicy < ApplicationPolicy


  def index?
    super or @current_user.leader?
  end

  def show?
    super or @current_user.leader? or @current_user == @model
  end

  def destroy?
    return false if @current_user == @model
    super
  end

end
