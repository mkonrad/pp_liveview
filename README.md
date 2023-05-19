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
locally. [Ref](#avl-phoenix-compose)

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

Initializing Phoenix Framework project...
Application container root............... /opt
Application name......................... pento
Running docker compose build...
Running phx.new umbrella...
...
* running mix deps.get
* running mix assets.setup
* running mix deps.compile

We are almost there! ...

The finalize step in the prepare script will handle these final steps and 
start the new application.

    $ ./prepare -f

pp\_liveview-app-1  | [watch] build finished, watching for changes...
pp\_liveview-app-1  | [info] Access PentoWeb.Endpoint at http://localhost:4000
pp\_liveview-app-1  |
pp\_liveview-app-1  | Rebuilding...
pp\_liveview-app-1  |
pp\_liveview-app-1  | Done in 891ms.

Open your favorite web browser and go to http://localhost:4000

![Localhost 4000](/docs/images/ppl-localhost-4000 "Programming Phoenix LiveView Default Landing Page")



References
----------

[avl-phoenix-compose]: (https://github.com/aviumlabs/phoenix-compose)
