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

  def changeset(step, attrs) do
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
    |> validate_unit()
    |> validate_time(:time)
  end

  defp validate_step(changeset) do
    changeset
    |> validate_required(:step_number)
    |> validate_number(:step_number, greater_than_or_equal_to: 0)
    |> validate_number(:step_number, less_than: 10000)
  end

  defp validate_ingredient(changeset) do
    changeset
    |> validate_length(:ingredient, max: 100)
    |> check_constraint(:ingredient,
      name: :if_ingredient_then_quantity_not_null,
      message: "Cannot specify an ingredient without also specifying a quantity"
    )
  end

  defp validate_quantity(changeset) do
    changeset
    |> validate_number(:quantity, greater_than_or_equal_to: 0)
    |> validate_number(:quantity, less_than: 10000)

    |> check_constraint(:quantity,
      name: :if_quantity_then_quatity_is_positive,
      message: "Quantity cannot be a negative number"
    )
  end

  defp validate_comment(changeset) do
    changeset
    |> validate_length(:comment, max: 500)
  end

  defp validate_unit(changeset) do
    changeset
    |> validate_length(:unit, max: 500)    
    |> check_constraint(:unit,
      name: :if_quantity_then_unit_not_null,
      message: "Cannot specify a quantity without also specifying a unit"
    )
  end

  defp validate_type(changeset) do
    changeset
    |> validate_length(:type, max: 500)
  end

  defp validate_temperature(changeset) do
    changeset
    |> validate_number(:temperature, less_than: 1000)
    |> validate_number(:temperature, greater_than: 0)
    |> check_constraint(:temperature,
      name: :if_temperature_then_temperature_is_positive,
      message: "Temperature cannot be a negative number"
    )
  end

  defp validate_time(changeset, field) when is_atom(field) do
    changeset
    |> dbg()
    |> validate_change(field, fn field, value ->
      IO.inspect(value)

      case is_interval_valid?(value) do
        false ->
          [{field, "Cannot be negative"}]

        true ->
          []
      end
    end)
  end

  defp is_interval_valid?(map) do
    map
    |> Map.from_struct()
    |> Map.delete(:microsecond)
    |> Enum.all?(fn {_key, value} ->
      value >= 0
    end)
    |> dbg()
  end
end
