class UserPolicy < ApplicationPolicy


  def show?
    @current_user.admin? or @current_user == @model
  end

  def destroy?
    return false if @current_user == @model
    super
  end

end
