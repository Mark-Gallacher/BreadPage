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

  defp changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:hydration, :total_time, :source, :user_id, :steps_id])
    |> validate_required([:source])
    |> validate_hydration()
    |> validate_source()
  end

  defp validate_hydration(changeset) do
    changeset
    |> validate_number(:hydration, great_than_or_equal: 0)
    |> validate_number(:hydration, less_than: 2)
  end

  defp validate_source(changeset) do
    changeset
    |> validate_length(:source, max: 500)
    |> validate_length(:source, min: 2)
  end
end
