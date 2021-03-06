# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blabl,
  ecto_repos: [Blabl.Repo]

# Configures the endpoint
config :blabl, BlablWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f3tlPc8jdEXX0XCmYyL5PA5dJNRJCqDApCuO3N33LC/d4596cBlabtoCHH+Gm5Y1",
  render_errors: [view: BlablWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blabl.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "sdl372bfjzgb5KLqjouTlmTJEig2SJvk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

config :blabl, Blabl.Auth.Guardian,
  issuer: "blabl",
  secret_key: "V2wpli2dYL6EWiS3rQVa2SHLUw6ABGtiqT9rnu3f7fB4P6BS5ahz2F4pN8O2o6PY"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
