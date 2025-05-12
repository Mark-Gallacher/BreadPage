defmodule Breadpage.Repo do
  use Ecto.Repo,
    otp_app: :breadpage,
    adapter: Ecto.Adapters.Postgres
end
