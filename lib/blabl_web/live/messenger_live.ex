defmodule BlablWeb.MessengerLive do
  @moduledoc false

  use Phoenix.LiveView

  alias Blabl.Messenger
  alias BlablWeb.MessengerView

  def render(assigns) do
    MessengerView.render("index.html", assigns)
  end

  def mount(%{current_user: current_user, rooms: rooms, active_room_id: active_room_id}, socket) do
    {:ok, assign(
      socket,
      current_user: current_user,
      rooms: rooms,
      active_room_id: active_room_id,
      message: Messenger.change_message()
    )}
  end

  def handle_event("show_room", room_id, %{assigns: %{current_user: user, rooms: rooms}} = socket) do
    {:noreply, assign(socket, active_room_id: String.to_integer(room_id))}
  end

  def handle_event("send_message", %{"message" => message_params}, socket) do
    %{active_room_id: active_room_id, rooms: rooms} = socket.assigns

    event = Messenger.create_message(message_params)
    events = [event | rooms[active_room_id].events]
    rooms = put_in(rooms, [active_room_id, Access.key!(:events)], events)

    {:noreply, assign(socket, rooms: rooms)}
  end
end
