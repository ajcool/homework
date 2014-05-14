class User
  attr_reader :roles

  def initialize()
    @roles = []
  end

  def add_role(role)
    @roles << role
  end

  def organizations(role_type=nil)
    orgs = []
    @roles.each do |role|
      if role_type.nil? || role_type == role.role_type
        orgs << role.target
        orgs += role.target.children
      end
    end

    orgs.uniq!

    denied_orgs = @roles.select{|r| r.role_type == "denied"}.map(&:target)

    orgs -= denied_orgs

    orgs
  end
end