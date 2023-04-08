defmodule CpgoWeb.WrongLive do
  use CpgoWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, score: 0, message: "Make a guess!!!")
    {:ok, socket}
  end

  def handle_event("guess", %{"number"=> guess}, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again."
    score = socket.assigns.score - 1
    {:noreply, assign(socket, message: message, score: score)}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>​
    ​ 	​
    <h2>​
      ​ 	​ <%= @message %>​
      ​ 	​</h2>​
    ​ 	​
    <h2>
      ​
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>​
    ​​        <%= n %>​
    ​​      </.link>​
        ​
      <% end %>
    </h2>​​
    """
  end
end
