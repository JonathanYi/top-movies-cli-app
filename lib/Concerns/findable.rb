module Concerns::Findable

  def find_by_name(name)
    all.detect{|object| object.name == name}
  end # find_by_name

  def find_or_create_by_name(name)
    find_by_name(name) || new(name)
  end # find_or_create_by_name

end
