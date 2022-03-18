import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :testing_live_view_wallaby, TestingLiveViewWallaby.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "testing_live_view_wallaby_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :testing_live_view_wallaby, TestingLiveViewWallabyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "YZJRcRqYdb9ChAFw+wuLQ2ArKyqYfosHKqg9AaoqDXlarAS8Ny7oSv3PrXwgdYq5",
  server: true

config :testing_live_view_wallaby, :sandbox, Ecto.Adapters.SQL.Sandbox

config :wallaby,
  otp_app: :testing_live_view_wallaby,
  screenshot_on_failure: true,
  chromedriver: [
    path: "assets/node_modules/chromedriver/bin/chromedriver",
    headless: false
  ]

# In test we don't send emails.
config :testing_live_view_wallaby, TestingLiveViewWallaby.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
