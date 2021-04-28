class Park
  attr_reader :name, :trails
  def initialize(name)
    @name = name
    @trails = []
  end

  def add_trail(trail)
    @trails.push(trail)
  end

  def trails_shorter_than(length_looked_for)
    @trails.find_all do |trail|
      trail.length <= length_looked_for
    end
  end

  def hikeable_miles
    trails.sum do |trail|
      trail.length
    end
  end

  def trails_by_level
    trail_hash = {}
    trails.each do |trail|
      if trail_hash[trail.level] == nil
        trail_hash[trail.level] = [trail.name]
      else
        trail_hash[trail.level].push(trail.name)
      end
    end
    trail_hash
  end

  def visitors_log
    hash = {}
    sorted_by_date = Hash.new
    hash[1980] = sorted_by_date
    hash[2020] = sorted_by_date
  end
end
