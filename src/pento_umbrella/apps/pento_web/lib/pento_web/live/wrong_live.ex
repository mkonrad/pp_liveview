defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view


  def mount(_params, _session, socket) do
    winning_number = game_number()
    {:ok, assign(socket, score: 0, winning_number: winning_number, message: "Make a guess:")}
  end

  @spec render(any) ::
  Phoenix.LiveView.Rendered.t()

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      <br />
    </h2>

    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number= {n} >
          <%= n %>
        </.link>
      <% end %>
    </h2>

    
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

    {message, s} =
      case g do
        ^wn ->
          {"Your guess: #{guess}. Winner!", 1}
        _ -> 
          {"Your guess: #{guess}. Wrong. Guess again.", -1} 
      end

    score = score + s

    {
      :noreply, 
      assign(
        socket,
        message: message,
        score: score)}
  end

  def game_number() do
    :rand.uniform(9) + 1
  end

end
