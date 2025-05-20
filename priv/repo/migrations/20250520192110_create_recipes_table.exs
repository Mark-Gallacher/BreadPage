defmodule Breadpage.Repo.Migrations.CreateRecipesTable do
  use Ecto.Migration

  def change do

    create table(:recipes) do
      add :hydration, :decimal, null: false
      add :prep_time, :duration, null: false
      add :bake_time, :duration, null: false
      add :source, :string
      
      add :user_id, references(:users, on_delete: :nothing)
      add :step_id, references(:steps, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:recipes, [:user_id])
  end
end
