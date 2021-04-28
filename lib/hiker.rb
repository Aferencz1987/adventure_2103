class Hiker
  attr_reader :name, :experience_level, :snacks, :parks_visited
  def initialize(name, experience_level)
    @name = name
    @experience_level = experience_level
    @snacks = {}
    @parks_visited = []
  end

  def pack(snack, amount)
    if @snacks[snack].nil?
      @snacks[snack] = amount
    else
      @snacks[snack] += amount
    end
  end

  def visit(park)
    @parks_visited.push(park)
  end

  def possible_trails
    @parks_visited.flat_map do |park|
      park.trails.find_all do |trail|
        trail.level == experience_level
      end
    end
  end

  def favorite_snack
    fave_snack = @snacks.max_by do |snack, amount|
      amount
    end
    fave_snack[0]
  end
end
