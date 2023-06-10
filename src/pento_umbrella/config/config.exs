# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :pento,
  ecto_repos: [Pento.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
# config :pento, Pento.Mailer, adapter: Swoosh.Adapters.Local
config :pento, Pento.Mailer, 
  adapter: Swoosh.Adapters.SMTP,
  relay: System.get_env("SMTP_SERVER"),
  port: System.get_env("SMTP_PORT"),
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  ssl: false,
  tls: :always,
  auth: :always,
  dkim: [
    s: "default", d: "aviumlabs.com",
    private_key: {:pem_plain, File.read!('/opt/pento_umbrella/apps/pento/priv/keys/aviumlabs.private')}
  ],
  retries: 2,
  no_mx_lookups: false

config :pento_web,
  ecto_repos: [Pento.Repo],
  generators: [context_app: :pento]

# Configures the endpoint
config :pento_web, PentoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: PentoWeb.ErrorHTML, json: PentoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Pento.PubSub,
  live_view: [signing_salt: "ZMFwg6SF"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/pento_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/pento_web/assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
