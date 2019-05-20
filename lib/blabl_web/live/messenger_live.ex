defmodule BlablWeb.MessengerLive do
  use Phoenix.LiveView

  alias Blabl.Messenger
  alias BlablWeb.MessengerView

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(session, socket) do
    send(self(), {:init_data, session[:user_id]})
    {:ok, assign(socket, user_id: nil, rooms: [], events: [], active_room: nil)}
  end

  def handle_info({:init_data, user_id}, socket) do
    rooms = Messenger.list_rooms(user_id)
    first_romm = rooms |> List.first
    events = Messenger.list_events(first_romm.id, user_id)

    {:noreply, assign(socket, user_id: user_id, rooms: rooms, events: events, active_room: first_romm)}
  end

  def handle_event("show_room", room_id, socket) do
    events = Messenger.list_events(room_id, socket.assigns.user_id)
    room = Messenger.get_room!(room_id)
    {:noreply, assign(socket, events: events, active_room: room)}
  end
end
