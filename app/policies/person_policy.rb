class PersonPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    @current_user.leader? || @current_user.admin?
  end

  def show?
    true
  end

  def edit?
    @current_user.admin?
  end

  def update?
    @current_user.leader? || @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end

end
