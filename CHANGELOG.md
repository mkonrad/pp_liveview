Programming Phoenix LiveView Chanelog
=====================================



Tags
----

| Tag     | Description                                 | Notes                |
|:-------:|---------------------------------------------|----------------------|
| 0.4.0   | SMTP configuraion for sending email         | Requires configuraion, 
see mailer notes below |
| 0.3.0   | Phoenix authentication OOTB                 |                      |
| 0.2.0   | Exercise 1, guessing game.                  | Game exercises       |
| 0.1.0   | Initial starting state - Phoenix OOTB       | Baseline             | 


2023-05-25 mailer
-----------------
New branch for testing email - mailer

    $ git branch mailer
    $ git checkout mailer

An OOTB mailer.ex file is established for us:

    pento_umbrella/apps/pento/lib/pento/mailer.ex

### File content
defmodule Pento.Mailer do
  use Swoosh.Mailer, otp\_app :pento
end

The OOTB mailer is using Phoenix.Swoosh, and we can go over to the documentation 
[page](https://hexdocs.pm/swoosh/Swoosh.html) to figure out the next steps.

Swoosh supports a plethora of commericial email services through it's adapter 
framework, including plain SMTP.

The confirmation emails for user registration, password reset, update email are 
located here:

    pento_umbrella/apps/lib/pento/accounts/user_notifier.ex 

For now, I'm going to test with the plain SMTP setup. 

Definitely worth moving to one of the services for a production application, 
where you want to track email delivery statistics. 

### Update mix.exs
As an umbrella application, there are several mix files, one for the umbrella, 
one for the web and one for the standard app.

Here we are updating the pento mix.exs file, if already has our swoosh dependency.

    pento_umbrella/apps/lib/pento/mix.exs

Add the line `{:gen_smtp, "~> 1.2"},`
under {:swoosh, ...}

### And new environment settings

Add the sensitive settings for SMTP, to the existing .env file in the root 
directory of the project.

    # SMTP variables 
    SMTP_SERVER="<smtp_server_host>"
    SMTP_PORT="<smtp_server_port>"
    SMTP_USERNAME="<smtp_server_username>"
    SMTP_PASSWORD="<smtp_server_password>"


### Update config.exs

    pento_umbrella/config/config.exs

Find the config :pento, Pento.Mailer, adapter: Swoosh.Adapters.Local entry and 
change it as follows:

`
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
    s: "default", d: "<your_domain>",
    private_key: {:pem_plain, File.read("apps/pento/priv/keys/<your_private_key>")}
  ],
  retries: 2,
  no_mx_lookups: false
`
  
Remember to add your private key to the .gitignore and .dockerignore files.

### Private Key
Create the keys directory and copy your private key:

    $ cd pento_umbrella/apps/pento
    $ mkdir priv/keys
    $ cp <your_private_key>/priv/keys

__Remember to add your private key to the .gitignore and .dockerignore files.__


### Application Restart
Add an additional alias and run amix deps.get

    $ alias amix="docker compose exec -w /opt/pento_umbrella/apps/pento app mix"
    $ amix deps.get
    
Restart the docker containers, and give registration a test

    $ cntl-c
    $ docker compose up

#### Output
`
pp_liveview-app-1  | ===> Analyzing applications...
pp_liveview-app-1  | ===> Compiling gen_smtp
pp_liveview-app-1  | ==> swoosh
pp_liveview-app-1  | Compiling 42 files (.ex)
pp_liveview-app-1  | Generated swoosh app
pp_liveview-app-1  | ==> pento
pp_liveview-app-1  | Compiling 2 files (.ex)
pp_liveview-app-1  | Generated pento app
pp_liveview-app-1  | ==> pento_web
pp_liveview-app-1  | Compiling 1 file (.ex)
pp_liveview-app-1  | Generated pento_web app
pp_liveview-app-1  | [info] Running PentoWeb.Endpoint with cowboy 2.10.0 at 0.0.0.0:4000 (http)
pp_liveview-app-1  | [info] Access PentoWeb.Endpoint at http://localhost:4000
pp_liveview-app-1  | [watch] build finished, watching for changes...
pp_liveview-app-1  | Browserslist: caniuse-lite is outdated. Please run:
pp_liveview-app-1  |   npx update-browserslist-db@latest
pp_liveview-app-1  |   Why you should do it regularly: https://github.com/browserslist/update-db#readme
pp_liveview-app-1  | 
pp_liveview-app-1  | Rebuilding...
pp_liveview-app-1  | 
pp_liveview-app-1  | Done in 1259ms.
`
 

2023-05-23 Running phx.gen.auth
-------------------------------
Adding authentication services is being completed in a new git branch - auth.

    $ git branch auth
    $ git checkout auth

Next we use the wmix alias to call the correct mix, under the umbrella 
application architecture.

    $ wmix phx.gen.auth Accounts User users

### Output
`
Do you want to create a LiveView based authentication system? [Yn] Y 
...
Please re-fetch your dependencies with the following command:

    $ mix deps.get

Remember to update your repository by running migrations:

    $ mix ecto.migrate

Once you are ready, visit "/users/register"
to create your account and then access "/dev/mailbox" to
see the account confirmation email.
`

Also need to use the wmix alias for these steps: 

### Command

    $ wmix deps.get

### Output
`
New:
  bcrypt_elixir 3.0.1
  comeonin 5.3.3
  elixir_make 0.7.6
* Getting bcrypt_elixir (Hex package)
* Getting comeonin (Hex package)
* Getting elixir_make (Hex package)
`

### Command

    $ wmix ecto.migrate

### Output
`
14:56:31.336 [info] == Running 20230523143109 Pento.Repo.Migrations.CreateUsersAuthTables.change/0 forward

14:56:31.424 [info] execute "CREATE EXTENSION IF NOT EXISTS citext"

14:56:31.478 [info] create table users

14:56:31.496 [info] create index users_email_index

14:56:31.498 [info] create table users_tokens

14:56:31.508 [info] create index users_tokens_user_id_index

14:56:31.511 [info] create index users_tokens_context_token_index

14:56:31.515 [info] == Migrated 20230523143109 in 0.0s
`


Next run the OOTB test:

    $ wmix test

** (Mix) The database for Pento.Repo couldn't be created: killed

I'll need to come back to that...


__Had to restart the containers in order for the bcrypt module to be loaded.__




References
----------

[avl-phoenix-compose]: https://github.com/aviumlabs/phoenix-compose
