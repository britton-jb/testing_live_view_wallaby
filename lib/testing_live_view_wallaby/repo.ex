defmodule TestingLiveViewWallaby.Repo do
  use Ecto.Repo,
    otp_app: :testing_live_view_wallaby,
    adapter: Ecto.Adapters.Postgres
end
