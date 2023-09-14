defmodule Ts1989Web.TallyLive do
  use Ts1989Web, :live_view

  alias Phoenix.PubSub

  @topic "increment_tally"

  @impl true
  def mount(_params, _session, socket) do
    PubSub.subscribe(Ts1989.PubSub, @topic)

    {:ok, assign(socket, names: [])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    VOTES <br /> 1989: <%= votes(assigns) %>
    <br /> Reputation: - <br /> Red (Taylor's Version): - <br /> Speak Now (Taylor's Version): -
    <br /> Midnights: -
    """
  end

  defp votes(%{names: []}), do: "-"

  defp votes(assigns) do
    ~H"""
    <%= for name <- @names do %>
      &#x1FAF6 <%= name %>
    <% end %>
    """
  end

  @impl true
  def handle_info({:add_one, name}, socket) do
    %{assigns: %{names: names}} = socket
    {:noreply, assign(socket, names: [name | names])}
  end
end
