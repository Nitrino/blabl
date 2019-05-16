defmodule BlablWeb.MessengerLive do
  use Phoenix.LiveView

  alias BlablWeb.MessengerView
  alias Blabl.Messenger.Rooms

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(session, socket) do
    rooms = Rooms.list_rooms(session[:user_id])
    {:ok, assign(socket, user_id: session[:user_id], rooms: rooms)}
  end
end
