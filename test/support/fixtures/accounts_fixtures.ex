defmodule Breadpage.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Breadpage.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        posts: [1, 2],
        username: "some username"
      })
      |> Breadpage.Accounts.create_user()

    user
  end
end
