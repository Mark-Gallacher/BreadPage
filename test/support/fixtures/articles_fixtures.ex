defmodule Breadpage.ArticlesFixtures do
  def valid_step_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      step_number: 1,
      ingredient: "strong white flour",
      quantity: Decimal.new(1000),
      unit: "grams",
      temperature: 25,
      type: "flour",
      comment: "High Protein Flour is ideal!",
      time: Duration.new!(hour: 5, minute: 30)
    })
  end

  # def valid_recipe_attributes(attrs) do
  # end

  # def valid_post_attributes do
  # end

  def steps_fixtures(attrs \\ %{}) do
    {:ok, step} =
      attrs
      |> valid_step_attributes()
      |> Breadpage.Articles.create_step()

    step
  end
end
