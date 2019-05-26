defmodule BlablWeb.MessengerLive do
  use Phoenix.LiveView

  alias Blabl.Messenger
  alias BlablWeb.MessengerView

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(session, socket) do
    send(self(), {:fetch_data, session[:user_id]})
    {:ok, assign(socket, user_id: nil, rooms: [], active_room_id: nil)}
  end

  def handle_info({:fetch_data, user_id}, socket) do
    rooms = fetch_rooms_map(user_id)
    {_, active_room} = Enum.at(rooms, 0)
    events = Messenger.list_events(active_room.id, user_id)
    {:noreply, assign(socket, user_id: user_id, rooms: rooms, active_room_id: active_room.id)}
  end

    {:noreply, assign(socket, user_id: user_id, rooms: rooms, events: events, active_room: first_romm)}
  end

  def handle_event("show_room", room_id, socket) do
    active_room = Map.get(socket.assigns.rooms, String.to_integer(room_id))
    events = Messenger.list_events(active_room.id, socket.assigns.user_id)
    {:noreply, assign(socket, active_room_id: active_room.id)}
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    %{active_room_id: active_room_id, user_id: user_id} = socket.assigns
    event = Messenger.create_message(%{text: message, room_id: active_room_id, user_id: user_id})

    events = [event | socket.assigns.rooms[active_room_id].events]

    rooms = put_in(socket.assigns.rooms, [active_room_id, Access.key!(:events)], events)

    {:noreply, assign(socket, rooms: rooms)}
  end

  def fetch_rooms_map(user_id) do
    case Messenger.list_rooms(user_id) do
      [] -> %{}
      rooms -> Enum.reduce(rooms, %{}, fn (room, acc) -> Map.put(acc, room.id, room) end)
    end
  end
end
