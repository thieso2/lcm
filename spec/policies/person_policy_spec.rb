describe PersonPolicy do
  subject { PersonPolicy }

  let (:assistant_user) { FactoryGirl.build_stubbed :user, :assistant }
  let (:leader_user)    { FactoryGirl.build_stubbed :user, :leader }
  let (:admin_user)     { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "allows access for an assistant" do
      expect(subject).to permit(assistant_user)
    end
    it "allows access for a leader" do
      expect(subject).to permit(leader_user)
    end
    it "allows access for an admin" do
      expect(subject).to permit(admin_user)
    end
  end

  permissions :show? do
    it "allow all users to show person data" do
      expect(subject).to permit(assistant_user, leader_user, admin_user)
    end
  end

  permissions :create? do
    it "prevents creates for assistants" do
      expect(subject).not_to permit(assistant_user)
    end
    it "allow all users to create person data" do
      expect(subject).to permit(leader_user, admin_user)
    end
  end

  permissions :update? do
    it "prevents updates for assistants" do
      expect(subject).not_to permit(assistant_user)
    end
    it "allows a leader and an admin to make updates" do
      expect(subject).to permit(leader_user, admin_user)
    end
  end

  permissions :destroy? do
    it "prevents deleting a person by non-admin" do
      expect(subject).not_to permit(assistant_user, leader_user)
    end
    it "allows an admin to delete any user" do
      expect(subject).to permit(admin_user)
    end
  end

end
