defmodule BlablWeb.MessengerView do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
      <h1>Messenger main page</h1>
    """
  end

  def mount(session, socket) do
    {:ok, assign(socket, [])}
  end
end
