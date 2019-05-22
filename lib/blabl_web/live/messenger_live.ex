defmodule BlablWeb.MessengerLive do
  use Phoenix.LiveView

  alias Blabl.Messenger
  alias BlablWeb.MessengerView

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(session, socket) do
    send(self(), {:fetch_data, session[:user_id]})
    {:ok, assign(socket, user_id: nil, rooms: [], s: [], active_room: nil)}
  end

  def handle_info({:fetch_data, user_id}, socket) do
    {:noreply, assign(socket, fetch_data(user_id))}
  end

    {:noreply, assign(socket, user_id: user_id, rooms: rooms, events: events, active_room: first_romm)}
  end

  def handle_event("show_room", room_id, socket) do
    events = Messenger.list_events(room_id, socket.assigns.user_id)
    room = Messenger.get_room!(room_id)
    {:noreply, assign(socket, events: events, active_room: room)}
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    %{active_room: active_room, user_id: user_id} = socket.assigns
    event = Messenger.create_message(%{text: message, room_id: active_room.id, user_id: user_id})
    events = socket.assigns.events ++ [event]
    {:noreply, assign(socket, events: events)}
  end

  def fetch_data(user_id) do
    rooms = Messenger.list_rooms(user_id)
    first_romm = rooms |> List.first
    events = Messenger.list_events(first_romm.id, user_id)

    [user_id: user_id, rooms: rooms, events: events, active_room: first_romm]
  end
end
