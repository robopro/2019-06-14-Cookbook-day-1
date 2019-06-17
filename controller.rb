require_relative 'view'
require_relative 'scrape_recipe_service'
require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

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
    name = @view.ask_for(:name)

    description = @view.ask_for(:description)

    prep_time = @view.ask_for(:"prep time")

    recipe = Recipe.new({name: name, description: description, prep_time: prep_time})

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

  # Scraper
  def import
    # get ingredient from user
    ingredient = @view.ask_for(:ingredient)

    # Parse data and return array of recipes
    recipes = ScrapeRecipeService.new(ingredient).call

    # Display recipes
    @view.display(recipes)
    # Ask user to select recipe
    index = @view.ask_for_index
    # Store recipe in our cookbook
    @cookbook.add_recipe(recipes[index])
  end

  def mark
    list

    index = @view.ask_for_index

    @cookbook.mark_as_done(index)
  end
end
