require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # first get all recipes from cookbook
    recipes = @cookbook.all
    # send data to view
    @view.display(recipes)
  end

  def create
    # add a new recipe:
    # ask user for name
    name = @view.ask_for(:name)
    # ask user for description
    description = @view.ask_for(:description)
    # create recipe from name and description
    recipe = Recipe.new(name, description)
    # pass recipe to cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # display all the recipes
    list
    # ask the user for which recipe
    index = @view.ask_for_index
    # delete recipe from cookbook
    @cookbook.remove_recipe(index)
    # show the new recipe
    list
  end
end
