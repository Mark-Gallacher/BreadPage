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
  end
end
