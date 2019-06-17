require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

class ScrapeRecipeService
  BASE_URL = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt="

  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    # Open URL
    url = "#{BASE_URL}#{@ingredient}"
    recipes = []

    html_file = open(url).read
    # Parse html
    html_doc = Nokogiri::HTML(html_file)
    # Get five first results
    html_doc.search('.m_contenu_resultat').take(5).each do |element|
      # Create recipes from search results
      name = element.search('.m_titre_resultat').text.strip
      description = element.search('.m_texte_resultat').text.strip
      prep_time = element.search('.m_prep_time').first.parent.text.strip
      recipes << Recipe.new({name: name, description: description, prep_time: prep_time})
    end

    return recipes
  end
end
