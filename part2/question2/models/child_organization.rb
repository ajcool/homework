class ChildOrganization
  def initialize()
    @roles = []
  end

  def add_role(role)
    @roles << role
  end

  def children
    []
  end
end