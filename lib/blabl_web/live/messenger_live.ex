defmodule BlablWeb.MessengerLive do
  use Phoenix.LiveView

  alias BlablWeb.MessengerView
  alias Blabl.Messenger

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(session, socket) do
    rooms = Messenger.list_rooms(session[:user_id])
    {:ok, assign(socket, user_id: session[:user_id], rooms: rooms, events: [])}
  end

  def handle_event("show_room", room_id, socket) do
    events = Messenger.list_events(room_id, socket.assigns.user_id)
    {:noreply, assign(socket,  events: events)}
  end
end
