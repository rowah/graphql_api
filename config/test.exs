import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :medium_graphql_api, MediumGraphqlApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "medium_graphql_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :medium_graphql_api, MediumGraphqlApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "HcpTweRvUN24Z+uRCi3XRRbP+DLWsUFshOXRgefYF88W1NwAP4YXmZhK9a6mDNoO",
  server: false

# In test we don't send emails
config :medium_graphql_api, MediumGraphqlApi.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# reduce the number of rounds not slow down your test suite
config :bcrypt_elixir, :log_rounds, 4
