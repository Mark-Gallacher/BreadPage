defmodule Breadpage.Repo.Migrations.AddConstraintsToSteps do
  use Ecto.Migration

  def change do
    ## if ingredient is supplied, make sure we have a quantity
    create constraint(:steps, "if_ingredient_then_quantity_not_null",
             check: "( ingredient IS NULL or quantity IS NOT NULL)",
             comment: "Quantity cannot be Empty when Ingredient is supplied."
           )

    ## if quantity is supplied, make sure we have a unit
    create constraint(:steps, "if_quantity_then_unit_not_null",
             check: "( quantity IS NULL or unit IS NOT NULL)",
             comment: "Units cannot be Empty when Quantity is supplied."
           )

    ## if quantity is supplied, make sure it is positive
    create constraint(:steps, "if_quantity_then_quantity_is_positive",
             check: "( quantity IS NULL or quantity > 0)",
             comment: "Quantity cannot be Negative."
           )

    ## if temperature is supplied, make sure it is positive
    create constraint(:steps, "if_temperature_then_temperature_is_positive",
             check: "( temperature IS NULL or temperature > 0)",
             comment: "Temperature cannot be Negative."
           )
  end
end
