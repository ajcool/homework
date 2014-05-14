class Role
  attr_reader :target, :role_type

  def initialize(user, target, role_type)
    @user = user
    @target = target
    @role_type = role_type
    @user.add_role(self)
    @target.add_role(self)
  end
end