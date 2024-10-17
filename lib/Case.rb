class Case
  attr_accessor :occupation
  def initialize
    @occupation = " "
  end

  def write(character)
    @occupation = character
  end

  def display
    print "#{@occupation}"
  end

end
