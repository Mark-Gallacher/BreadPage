defmodule Breadpage.Repo.Migrations.AddUnitsColumnToSteps do
  use Ecto.Migration

  def change do
    alter table(:steps) do
      add :unit, :string
    end
  end
end
