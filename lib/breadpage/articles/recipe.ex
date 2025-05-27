defmodule Breadpage.Articles.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  @foreign_key_type :id
  schema "recipes" do
    field :hydration, :decimal
    field :prep_time, :duration
    field :bake_time, :duration
    field :source, :string

    timestamps(type: :utc_datetime)

    belongs_to :user, Breadpage.Accounts.User
    belongs_to :step, Breadpage.Articles.Step
    has_one :post, Breadpage.Articles.Post
  end

  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:hydration, :prep_time, :bake_time, :source])
    |> validate_required([:hydration, :prep_time, :bake_time, :source])
    |> validate_hydration()
    |> validate_source()
    |> validate_interval([:prep_time, :bake_time])
  end

  defp validate_hydration(changeset) do
    changeset
    |> validate_number(:hydration, greater_than_or_equal_to: 0)
    |> validate_number(:hydration, less_than: 2)
    |> check_constraint(:hydration,
      name: :hydration_always_positive,
      message: "Hydration should always be positive"
    )
  end

  defp validate_source(changeset) do
    changeset
    |> validate_length(:source, max: 500)
    |> validate_length(:source, min: 2)
  end

  defp validate_interval(changeset, field) when is_list(field) do
    Enum.reduce(field, changeset, fn field, changeset ->
      changeset
      |> validate_interval(field)
    end)
  end

  defp validate_interval(changeset, field) when is_atom(field) do
    changeset
    |> validate_change(field, fn field, value ->
      case is_interval_valid?(value) do
        false ->
          [{field, "Cannot be negative"}]

        true ->
          []
      end
    end)
    |> check_constraint(field,
      name: field,
      match: :prefix,
      message: "Durations should always be positive"
    )
  end

  defp is_interval_valid?(map) do
    map
    |> Map.from_struct()
    |> Map.delete(:microsecond)
    |> Enum.all?(fn {_key, value} ->
      value >= 0
    end)
  end
end
