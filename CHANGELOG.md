Programming Phoenix LiveView Chanelog
=====================================



Tagged Versions
---------------

| Version | Description                                 | Notes                |
|---------|--------------------------------------------------------------------|
| 0.3.0   | Phoenix authentication OOTB                 |                      |
| 0.2.0   | Exercise 1, guessing game.                  | Game exercises       |
| 0.1.0   | Initial starting state - Phoenix OOTB       | Baseline             | 


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
