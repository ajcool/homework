class RootOrganization
  def initialize(organizations)
    @organizations = organizations
    @roles = []
  end

  def children
    descendants = @organizations
    @organizations.each do |org|
      descendants += org.children
    end
    descendants
  end

  def add_role(role)
    @roles << role
  end
end