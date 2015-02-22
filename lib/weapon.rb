class Weapon

  attr_accessor :type, :paper, :scissors, :rock

  def paper
    @type = "paper"
  end

  def scissors
    @type = "scissors"
  end

  def rock
    @type = "rock"
  end

  def random_weapon
    [rock,scissors,paper].shuffle.last
  end

end