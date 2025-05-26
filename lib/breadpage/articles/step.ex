defmodule Breadpage.Articles.Step do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  @foreign_key_type :id
  schema "steps" do
    field :step_number, :integer
    field :ingredient, :string
    field :quantity, :decimal
    field :unit, :string
    field :time, :duration
    field :temperature, :integer
    field :type, :string
    field :comment, :string

    timestamps(type: :utc_datetime)
  end

  defp changeset(step, attrs) do
    step
    |> cast(attrs, [
      :step_number,
      :ingredient,
      :quantity,
      :unit,
      :time,
      :temperature,
      :type,
      :comment
    ])
    |> validate_step()
    |> validate_ingredient()
    |> validate_quantity()
    |> validate_comment()
    |> validate_temperature()
    |> validate_type()
  end

  defp validate_step(changeset) do
    changeset
    |> validate_required(:step_number)
    |> validate_number(:step_number, greater_than_or_equal: 0)
    |> validate_number(:step_number, less_than: 10000)
  end

  defp validate_ingredient(changeset) do
    changeset
    |> validate_length(:ingredient, max: 100)
  end

  defp validate_quantity(changeset) do
    changeset
    |> validate_number(:quantity, greater_than_or_equal: 0)
    |> validate_number(:quantity, less_than: 10000)
  end

  defp validate_comment(changeset) do
    changeset
    |> validate_length(:comment, max: 500)
  end

  defp validate_type(changeset) do
    changeset
    |> validate_length(:type, max: 500)
  end

  defp validate_temperature(changeset) do
    changeset
    |> validate_number(:temperature, less_than: 1000)
    |> validate_number(:temperature, greater_than: -100)
  end
end
