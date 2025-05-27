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

    test "create_step/2 with valid missing data" do
      valid_step = %{step_number: 1, time: Duration.new!(hour: 1)}
      assert {:ok, %Step{} = step} = Articles.create_step(valid_step)

      assert step.step_number == 1
      assert step.ingredient == nil
      assert step.quantity == nil
      assert step.unit == nil
      assert step.temperature == nil
      assert step.type == nil
      assert step.comment == nil
      assert step.time == Duration.new!(hour: 1)
    end

    test "create_step/2 with too many missing fields" do
      invalid_step = %{step_number: 1}

      assert {:error, %Ecto.Changeset{} = changeset} =
               Articles.create_step(invalid_step)

      assert changeset.valid? == false

      assert %{ingredient: ["step should contain an ingredient, time or temperature"]} =
               errors_on(changeset)
    end

    test "create_step/2 with invalid step_number" do
      valid_step = Breadpage.ArticlesFixtures.valid_step_attributes()

      assert {:error, %Ecto.Changeset{} = changeset} =
               Articles.create_step(Map.delete(valid_step, :step_number))

      assert changeset.valid? == false
      assert %{step_number: ["can't be blank"]} = errors_on(changeset)
    end

    test "create_step/2 with missing quantity" do
      valid_step = Breadpage.ArticlesFixtures.valid_step_attributes()

      assert {:error, %Ecto.Changeset{} = changeset} =
               Articles.create_step(Map.delete(valid_step, :quantity))

      assert changeset.valid? == false

      assert %{ingredient: ["cannot specify an ingredient without also specifying a quantity"]} =
               errors_on(changeset)
    end

    test "create_step/2 with missing units" do
      valid_step = Breadpage.ArticlesFixtures.valid_step_attributes()

      assert {:error, %Ecto.Changeset{} = changeset} =
               Articles.create_step(Map.delete(valid_step, :unit))

      assert changeset.valid? == false

      assert %{unit: ["cannot specify a quantity without also specifying a unit"]} =
               errors_on(changeset)
    end

    test "create_step/2 with invalid temperature" do
      invalid_step = Breadpage.ArticlesFixtures.valid_step_attributes(%{temperature: -1})

      assert {:error, %Ecto.Changeset{} = changeset} =
               Articles.create_step(invalid_step)

      assert changeset.valid? == false

      assert %{temperature: ["must be greater than 0"]} =
               errors_on(changeset)
    end

    test "create_step/2 with invalid quantity" do
      invalid_step = Breadpage.ArticlesFixtures.valid_step_attributes(%{quantity: -1})

      assert {:error, %Ecto.Changeset{} = changeset} =
               Articles.create_step(invalid_step)

      assert changeset.valid? == false

      assert %{quantity: ["must be greater than or equal to 0"]} =
               errors_on(changeset)
    end

    test "create_step/2 with invalid time" do
      invalid_step =
        Breadpage.ArticlesFixtures.valid_step_attributes(%{time: Duration.new!(hour: -1)})

      assert {:error, %Ecto.Changeset{} = changeset} =
               Articles.create_step(invalid_step)

      assert changeset.valid? == false

      assert %{time: ["cannot be negative"]} =
               errors_on(changeset)
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
