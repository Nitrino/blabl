defmodule BlablWeb.MessengerLive do
  use Phoenix.LiveView

  alias Blabl.Messenger
  alias BlablWeb.MessengerView

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(session, socket) do
    rooms = Messenger.list_rooms(session[:user_id])
    first_romm = rooms |> List.first
    events = Messenger.list_events(first_romm.id, session[:user_id])
    {:ok, assign(socket, user_id: session[:user_id], rooms: rooms, events: events, active_room_id: first_romm.id)}
  end

  def handle_event("show_room", room_id, socket) do
    events = Messenger.list_events(room_id, socket.assigns.user_id)
    {:noreply, assign(socket, events: events, active_room_id: String.to_integer(room_id))}
  end
end
