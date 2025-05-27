defmodule Breadpage.Repo.Migrations.AddConstraintToStepTable do
  use Ecto.Migration

  def change do
    ## if quantity is supplied, make sure we have a unit
    create constraint(:steps, "ensure_one_attribute_is_not_null",
             check: "(ingredient IS NOT NULL or time IS NOT NULL or temperature IS NOT NULL)",
             comment: "Step should contain an ingredient, time or temperature"
           )
  end
end
