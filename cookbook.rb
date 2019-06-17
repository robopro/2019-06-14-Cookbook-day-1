require 'csv'
require 'byebug'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv_file
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(index)
     @recipes.delete_at(index)
     save_to_csv
  end

  private

  def load_csv_file
    CSV.foreach(@csv_file_path) do |row|
      # ["Crumpets", "Crumpets description"]
      # load csv
      # read csv row by row
      # name = row[0]
      # description = row[1]
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end
