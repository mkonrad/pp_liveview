defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    winning_number = game_number()

    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        session_id: session["live_socket_id"],
        winning_number: winning_number,
        winner: false
      )
    }
  end

  @spec render(any) ::
  Phoenix.LiveView.Rendered.t()

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>

    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" class="rounded-lg bg-zinc-100 px-2 py-1 hover:bg-zinc-200/80" phx-click="guess" phx-value-number= {n} >
        
          <%= n %>
        
        </.link>
      <% end %>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>

    <%= if @winner == true do %>
      <.link patch={~p"/guess"} class="rounded-lg bg-rose-400 px-2 py-1 hover:bg-rose-400/80">Play again?</.link>
    <% end %>
    
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess}, socket) do

    # Check if guess matches winning number
    # Comparision requires converting guess to integer
    wn = socket.assigns.winning_number 
    g = String.to_integer(guess)
    score = socket.assigns.score

    {message, s, winner} =
      case g do
        ^wn ->
          {"Your guess: #{guess}. Winner!", 1, true}
        _ -> 
          {"Your guess: #{guess}. Wrong. Guess again.", -1, false} 
      end

    score = score + s

    {
      :noreply, 
      assign(
        socket,
        message: message,
        score: score,
        winner: winner)}
  end

  def game_number() do
    :rand.uniform(9) + 1
  end

end
