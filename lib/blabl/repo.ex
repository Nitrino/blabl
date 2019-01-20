defmodule Blabl.Repo do
  use Ecto.Repo,
    otp_app: :blabl,
    adapter: Ecto.Adapters.Postgres
end
