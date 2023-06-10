defmodule PentoWeb.Plug.Redirector do

  def init([to: _] = opts), do: opts
  def init(_default), do: raise("Missing requied to: option in redirect.") 

  def call(conn, opts) do
    conn
    |> Phoenix.Controller.redirect(opts)

  end
end
