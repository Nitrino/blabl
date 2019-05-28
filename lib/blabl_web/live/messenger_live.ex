defmodule BlablWeb.MessengerLive do
  @moduledoc false

  use Phoenix.LiveView

  alias Blabl.Messenger
  alias BlablWeb.MessengerView

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(%{current_user: current_user, rooms: rooms, active_room_id: active_room_id}, socket) do
    rooms
    |> Map.values()
    |> Messenger.subscribe_to_rooms()

    {:ok,
     assign(
       socket,
       current_user: current_user,
       rooms: rooms,
       active_room_id: active_room_id,
       message: Messenger.change_message()
     )}
  end

  def handle_event("show_room", room_id, socket) do
    {:noreply, assign(socket, active_room_id: String.to_integer(room_id))}
  end

  def handle_event("send_message", %{"message" => message_params}, socket) do
    %{active_room_id: active_room_id, rooms: rooms} = socket.assigns

    event = Messenger.create_message(message_params)
    events = [event | rooms[active_room_id].events]
    rooms = put_in(rooms, [active_room_id, Access.key!(:events)], events)

    BlablWeb.Endpoint.broadcast_from(self(), Messenger.topic(event.room_id), "new_message", %{rooms: rooms})

    {:noreply, assign(socket, rooms: rooms)}
  end

  def handle_info(%{event: "new_message", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end
end
