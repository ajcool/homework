class Organization
  attr_reader :children

  def initialize(children)
    @children = children
    @roles = []
  end

  def add_role(role)
    @roles << role
  end
end