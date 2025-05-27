defmodule Breadpage.ArticlesFixtures do
  alias Breadpage.AccountsFixtures

  def valid_step_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      step_number: 1,
      ingredient: "strong white flour",
      quantity: Decimal.new("1000"),
      unit: "grams",
      temperature: 25,
      type: "flour",
      comment: "High Protein Flour is ideal!",
      time: Duration.new!(hour: 5, minute: 30)
    })
  end

  def valid_recipe_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      hydration: Decimal.new("0.7"),
      prep_time: Duration.new!(hour: 5, minute: 30),
      bake_time: Duration.new!(hour: 4, minute: 5),
      source: "self"
    })
  end

  defp add_recipe_associations() do
  end

  # def valid_post_attributes do
  # end

  def steps_fixtures(attrs \\ %{}) do
    {:ok, step} =
      attrs
      |> valid_step_attributes()
      |> Breadpage.Articles.create_step()

    step
  end

  def recipe_fixtures(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> valid_recipe_attributes()
      |> Breadpage.Articles.create_recipe()

    recipe
  end
end
