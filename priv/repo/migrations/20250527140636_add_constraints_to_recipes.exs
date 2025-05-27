defmodule Breadpage.Repo.Migrations.AddConstraintsToRecipes do
  use Ecto.Migration

  def change do
    create constraint(:recipes, :hydration_always_positive,
             check: "hydration > 0",
             comment: "Hydration should always be positive."
           )

    create constraint(:recipes, :bake_time_always_positive,
             check: "bake_time > '0'::interval",
             comment: "Bake Time should always be a positive duration"
           )

    create constraint(:recipes, :prep_time_always_positive,
             check: "prep_time > '0'::interval",
             comment: "Prep Time should always be a positive duration"
           )
  end
end
