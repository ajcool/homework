Dir["models/*.rb"].each { |f| require_relative f }

describe "User" do
  context "#organizations" do
    before :each do
      # Set up the structure
      @user = User.new
      @child1 = ChildOrganization.new
      @child2 = ChildOrganization.new
      @child3 = ChildOrganization.new
      @org1 = Organization.new([@child1, @child2])
      @org2 = Organization.new([@child3])
      @root_org = RootOrganization.new([@org1, @org2])
    end

    it "should return a child org if the user has a role on it" do
      @role = Role.new(@user, @child1, "user")
      @user.organizations.should include(@child1)
    end

    it "should return an org and all children if the user has a role on it" do
      @role = Role.new(@user, @org2, "user")
      @user.organizations.should include(@org2, @child3)
    end

    it "should return all orgs, child orgs, and the root org if the user has a role on the root org" do
      @role = Role.new(@user, @root_org, "user")
      @user.organizations.should include(@root_org, @org1, @org2, @child1, @child2, @child3)
    end

    it "should not return an org or child org on which the user has a 'denied' role" do
      @role = Role.new(@user, @org1, "user")
      @denied = Role.new(@user, @child1, "denied")
      orgs = @user.organizations
      orgs.should include(@org1, @child2)
      orgs.should_not include(@child1)
    end

    it "should return orgs of a specified role type" do
      @role = Role.new(@user, @org1, "user")
      @admin_role = Role.new(@user, @org2, "admin")
      user_orgs = @user.organizations("user")
      admin_orgs = @user.organizations("admin")
      user_orgs.should include(@org1, @child1, @child2)
      user_orgs.should_not include(@org2)
      admin_orgs.should include(@org2, @child3)
      admin_orgs.should_not include(@org1)
    end
  end
end