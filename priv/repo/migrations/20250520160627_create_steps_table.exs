defmodule Breadpage.Repo.Migrations.CreateStepsTable do
  use Ecto.Migration

  def change do
    
    create table(:steps) do
      add :step_number, :integer, null: :false
      add :ingredient, :string
      add :quantity, :decimal
      add :time, :duration
      add :temperature, :integer
      add :type, :string
      add :comment, :string, size: 500

      timestamps(type: :utc_datetime)
    end

    create index(:steps, [:id])
  end
end
