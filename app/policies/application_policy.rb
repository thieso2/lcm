class ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user = current_user
    @model = model
  end

  def index?
    current_user.admin?
  end

  def show?
    current_user.admin?
  end

  def edit?
    update?
  end
  def update?
    current_user.admin?
  end

  def new?
    create?
  end
  def create?
    current_user.admin?
  end


  def destroy?
    current_user.admin?
  end


end
