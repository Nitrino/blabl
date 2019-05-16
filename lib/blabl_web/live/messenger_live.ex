defmodule BlablWeb.MessengerLive do
  use Phoenix.LiveView

  alias BlablWeb.MessengerView

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(session, socket) do
    {:ok, assign(socket, [])}
  end
end
