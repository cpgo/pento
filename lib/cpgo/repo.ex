defmodule Cpgo.Repo do
  use Ecto.Repo,
    otp_app: :cpgo,
    adapter: Ecto.Adapters.Postgres
end
