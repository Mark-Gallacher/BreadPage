defmodule Breadpage.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  def change do

    create table(:posts) do
      add :title, :string, null: false
      add :description, :string, size: 500
      add :active, :boolean, null: false
      add :tags, {:array, :string}
      add :user_id, references(:users, on_delete: :delete_all)
      add :recipe_id, references(:recipes, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:posts, [:user_id])
    create index(:posts, [:recipe_id])
  end
end
