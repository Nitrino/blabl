defmodule BlablWeb.MessengerController do
  use BlablWeb, :controller

  plug :put_layout, "messenger.html"

  alias Blabl.Messenger
  import Phoenix.LiveView.Controller

  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    rooms = Messenger.list_rooms_map(current_user)
    {_, active_room} = Enum.at(rooms, 0)

    live_render(conn, BlablWeb.MessengerLive,
      session: %{
        current_user: current_user,
        rooms: rooms,
        active_room_id: active_room.id
      }
    )
  end
end
