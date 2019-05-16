defmodule BlablWeb.MessengerController do
  use BlablWeb, :controller

  import Phoenix.LiveView.Controller

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    live_render(conn, BlablWeb.MessengerLive, session: %{user_id: user.id})
  end
end
