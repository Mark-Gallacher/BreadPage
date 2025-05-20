defmodule Breadpage.Articles.Step do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  @foreign_key_type :id
  schema "steps" do
    field :step_number, :integer
    field :ingredient, :string
    field :quantity, :decimal
    field :time, :duration
    field :temperature, :integer
    field :type, :string
    field :comment, :string

    timestamps(type: :utc_datetime)
  end

  defp changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:ingredient, :quantity, :time, :temperature, :type, :comment])
  end
end
