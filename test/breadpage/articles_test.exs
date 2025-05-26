defmodule Breadpage.ArticlesTest do
  use Breadpage.DataCase
  
  alias Breadpage.Articles

  import Breadpage.ArticlesFixtures
  import Breadpage.AccountsFixtures

  describe "steps" do
    alias Breadpage.Articles.Step

    test "create_step/2 with valid data" do
      
      valid_step = Breadpage.ArticlesFixtures.valid_step_attributes()

      assert {:ok, %Step{} = step } = Articles.create_step(valid_step)
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
end
