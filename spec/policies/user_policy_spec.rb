describe UserPolicy do
  subject { UserPolicy }

  let (:assistant_user) { FactoryGirl.build_stubbed :user, :assistant }
  let (:leader_user)    { FactoryGirl.build_stubbed :user, :leader }
  let (:admin_user)     { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "denies access for an assistant" do
      expect(subject).not_to permit(assistant_user)
    end
    it "allows access for a leader" do
      expect(subject).to permit(leader_user)
    end
    it "allows access for an admin" do
      expect(subject).to permit(admin_user)
    end
  end

  permissions :show? do
    it "allows assistant users to show own user data" do
      expect(subject).to permit(assistant_user, assistant_user)
    end
    it "denies assistant users to show user data" do
      expect(subject).not_to permit(assistant_user)
    end
    it "allows leader users to show user data" do
      expect(subject).to permit(leader_user)
    end
    it "allows admin users to show user data" do
      expect(subject).to permit(admin_user)
    end
  end

  permissions :create? do
    it "prevents creates for non-admins" do
      expect(subject).not_to permit(assistant_user)
      expect(subject).not_to permit(leader_user)
    end
    it "allow admin users to create user data" do
      expect(subject).to permit(admin_user)
    end
  end

  # no need to test edit? - is only presentation of a form; save permission is checked by update?

  permissions :update? do
    it "prevents updates for non-admins" do
      expect(subject).not_to permit(assistant_user)
      expect(subject).not_to permit(leader_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin_user)
    end
  end

  permissions :destroy? do
    it "denies deleting a user by non-admin" do
      expect(subject).not_to permit(assistant_user)
      expect(subject).not_to permit(leader_user)
    end
    it "allows an admin to delete any user" do
      expect(subject).to permit(admin_user, assistant_user)
      expect(subject).to permit(admin_user, leader_user)
    end
    it "prevents an admin to delete himself" do
      expect(subject).not_to permit(admin_user, admin_user)
    end
  end

end
