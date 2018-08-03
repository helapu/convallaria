# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :convallaria,
  ecto_repos: [Convallaria.Repo]

# Configures the endpoint
config :convallaria, ConvallariaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bMdFSQ/71HvV3pKbxI7IyE5S1Ua8BgI+6w8IjChLn/YXY7pTV0NbJkzAqDyVDyhX",
  render_errors: [view: ConvallariaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Convallaria.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
