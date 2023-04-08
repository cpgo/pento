defmodule CpgoWeb.WrongLive do
  use CpgoWeb, :live_view

  def mount(_params, _session, socket) do
    correct_number = to_string(:rand.uniform(10))

    socket = assign(socket, score: 0, message: "Make a guess!!!", correct: correct_number)
    {:ok, socket}
  end

  def time() do
    DateTime.utc_now() |> to_string()
  end

  def handle_event("guess", %{"number" => guess}, socket) when guess == socket.assigns.correct do
    message = "You win"
    score = socket.assigns.score + 1

    {:noreply, assign(socket, message: message, score: score)}
  end

  def handle_event("guess", %{"number" => _guess}, socket) do
    message = "You lose"
    score = socket.assigns.score - 1

    {:noreply, assign(socket, message: message, score: score)}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>​
    ​ 	​
    <h2>​
      ​ <%= @message %>​
      ​</h2>​
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
