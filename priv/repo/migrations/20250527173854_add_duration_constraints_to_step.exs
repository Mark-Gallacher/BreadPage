defmodule Breadpage.Repo.Migrations.AddDurationConstraintsToStep do
  use Ecto.Migration

  def change do
    create constraint(:steps, :if_time_then_time_always_positive,
             check: "( time IS NULL or (time > '0'::interval) )",
             comment: "Time cannt be negative when supplied"
           )
  end
end
