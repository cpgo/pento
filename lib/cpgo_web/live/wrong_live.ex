defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def initial_state(socket) do
    correct_number = to_string(:rand.uniform(10))
    # correct_number = "1"
    socket = assign(socket, score: 0, message: "Make a guess!!!", picks: [], correct: correct_number)

    socket
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> initial_state()

    {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    socket = initial_state(socket)
    {:noreply, socket}
  end

  def time() do
    DateTime.utc_now() |> to_string()
  end

  def handle_event("guess", %{"number" => guess}, socket) when guess == socket.assigns.correct do
    message = "You win"
    score = socket.assigns.score + 1
    picks = [guess | socket.assigns.picks]
    socket = push_event(socket, "correct", %{id: "btn-#{guess}"})
    {:noreply, assign(socket, message: message, score: score, picks: picks)}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    message = "You lose"
    score = socket.assigns.score - 1
    picks = [guess | socket.assigns.picks]

    {:noreply, assign(socket, message: message, score: score, picks: picks)}
  end

  def picked?(picks, number, correct) do
    string_guess = Integer.to_string(number)
    Enum.member?(picks, string_guess) && string_guess != correct
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>​
    ​ <.link patch={~p"/guess"}>Restart</.link>
    <h2>​
      ​ <%= @message %>​
      ​</h2>​
    ​ 	​
    ​<div class="flex justify-evenly">
      <%= for n <- 1..10 do %>
        <.button phx-click="guess" data-correct={JS.transition("animate-spin", time: 1000)} phx-value-number={n} id={"btn-#{n}"} class={if picked?(@picks, n, @correct), do: "invisible"}>​
          ​​ <%= n %>​
          ​​</.button>​
      <% end %>
    </div>
    """
  end
end
