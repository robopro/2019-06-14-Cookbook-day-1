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

  def mark_as_done(index)
    @recipes[index].mark_as_done!
    save_to_csv
  end

  private

  def load_csv_file
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # byebug
      row[:done] = row[:done] == "true"
      @recipes << Recipe.new(row)
    end
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['name', 'description', 'prep_time', 'done']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done?]
      end
    end
  end
end
