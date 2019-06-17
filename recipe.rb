class Recipe
  attr_reader :name, :description, :prep_time

  # **attributes is the same as attributes = {}
  # *attributes is the same as attributes = []
  def initialize(**attributes)
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end

  def to_s
    status = done? ? "[X]" : "[ ]"
    "#{status} "\
    "Name: #{@name} | "\
    "Description: #{@description[0..20]} | "\
    "Prep: #{@prep_time} | "
  end
end
