defmodule Breadpage.Articles.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "posts" do
    field :title, :string
    field :description, :string
    field :active, :boolean
    field :tags, {:array, :string}
    timestamps(type: :utc_datetime)

    belongs_to :user, Breadpage.Accounts.User
    belongs_to :recipe, Breadpage.Articles.Recipe
  end

  defp changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :tags, :user_id, :recipe_id])
    |> validate_required([:title, :user_id, :recipe_id])
    |> validate_title()
    |> validate_description()
    |> validate_length(:description, max: 500)
  end

  defp validate_title(changeset) do
    changeset
    |> validate_length(:title, min: 8, max: 120)
  end

  defp validate_description(changeset) do
    changeset
    |> validate_length(:description, max: 500)
  end
end
