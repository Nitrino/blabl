use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :blabl, BlablWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :blabl, Blabl.Repo,
  username: "postgres",
  password: "postgres",
  database: "blabl_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :blabl, Blabl.Guardian,
  issuer: "Blabl",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: "zFSwwjUcAyzGroJamjGWGhTsgQLiSQQpr8Ut5H+IRiDUuXASXxXDCwz5Fgna+iee"

if File.exists?("config/test.secret.exs") do
  import_config "test.secret.exs"
end
