Programming Phoenix LiveView Notes
==================================

Local Environment
-----------------
These steps have been performed on macOS Ventura.

Local Software Prerequisites
----------------------------
The following software is required to be installed locally to use the 
aviumlabs/phoenix-compose template.

- Docker
- GitHub CLI
- Git

Create GitHub Project 
---------------------
The following command will generate a GitHub repository from the 
aviumlabs/phoenix-compose template repository and clone the new repository 
locally. [Avium Labs Phoenix Compose Reference] [avl-phoenix-compose]

    $ cd <projects/directory>
    $ gh repo create pp_liveview -c -d "A Phoenix LiveView Project" --public \
      -p aviumlabs/phoenix-compose

### Avium Labs Prepare Script 

The prepare script is included with the repository and is utilized to configure 
the Phoenix Framework project with docker. 

The following commands will initialize the project wih the supplied name and 
it will create the Phoenix Framework project as an umbrella application.

    $ cd pp_liveview
    $ ./prepare -i pento -u

Initializing Phoenix Framework project...<br />
Application container root............... /opt<br />
Application name......................... pento<br />
Running docker compose build...<br />
Running phx.new umbrella...<br />

...
* running mix deps.get
* running mix assets.setup
* running mix deps.compile

We are almost there! ...

The finalize step in the prepare script will handle these final steps and 
start the new application.

    $ ./prepare -f

pp\_liveview-app-1  | [watch] build finished, watching for changes...<br />
pp\_liveview-app-1  | [info] Access PentoWeb.Endpoint at http://localhost:4000<br />
pp\_liveview-app-1  |<br />
pp\_liveview-app-1  | Rebuilding...<br />
pp\_liveview-app-1  |<br />
pp\_liveview-app-1  | Done in 891ms.<br />

Open your favorite web browser and go to http://localhost:4000 and you should 
see the following page:

![Localhost 4000](/docs/images/ppl-localhost-4000.png
"Programming Phoenix LiveView Default Landing Page")

Running iex
-----------
In the docker environment, running iex is a bit different. 

Here will will use the docker compose exec command. To do so, we need to be in 
the parent directory pp\_liveview:

    $ cd pp_liveview
    $ docker compose exec app iex -S mix

Interactive Elixir (1.14.4) - press Ctrl+c to exit (type h() ENTER for help)<br />
iex(1)> 

We can create an alias for iex to reduce our typing:

    $ alias iex="docker compose exec app iex"

Then to start iex, we just run it like we normally would:

    $ iex -S mix



References
----------

[avl-phoenix-compose]: https://github.com/aviumlabs/phoenix-compose
