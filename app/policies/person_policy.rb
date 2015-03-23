class PersonPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    # @current_user.admin?
    true
  end
  
  def new?
    true
  end
  
  def create?
    true
  end    

  def show?
    @current_user.admin? or @current_user == @person
  end
  
  def edit?
    @current_user.admin?
  end

  def update?
    @current_user.admin?
    true
  end

  def destroy?
    return false if @current_user == @person
    @current_user.admin?
  end

end
