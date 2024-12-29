defmodule AuroraUixDemo.Repo do
  use Ecto.Repo,
    otp_app: :aurora_uix_demo,
    adapter: Ecto.Adapters.Postgres
end
