defmodule Breadpage.ArticlesTest do
  use Breadpage.DataCase

  alias Breadpage.Articles
  alias Breadpage.Articles.Recipe
  alias Breadpage.Articles.Step

  describe "steps" do
    test "create_step/2 with valid data" do
      valid_step = Breadpage.ArticlesFixtures.valid_step_attributes()
      assert {:ok, %Step{} = step} = Articles.create_step(valid_step)

      assert step.step_number == 1
      assert step.ingredient == "strong white flour"
      assert step.quantity == Decimal.new(1000)
      assert step.unit == "grams"
      assert step.temperature == 25
      assert step.type == "flour"
      assert step.comment == "High Protein Flour is ideal!"
      assert step.time == Duration.new!(hour: 5, minute: 30)
    end
  end

  describe "recipes" do
    test "create_recipe/2 with valid data" do
      # valid_step = Breadpage.ArticlesFixtures.valid_step_attributes()
      # assert {:ok, %Step{} = step} = Articles.create_step(valid_step)

      valid_recipe = Breadpage.ArticlesFixtures.valid_recipe_attributes()
      assert {:ok, %Recipe{} = recipe} = Articles.create_recipe(valid_recipe)

      assert recipe.hydration == Decimal.new("0.7")
      assert recipe.prep_time == Duration.new!(hour: 5, minute: 30)
      assert recipe.bake_time == Duration.new!(hour: 4, minute: 5)
      assert recipe.source == "self"
    end
  end
end
