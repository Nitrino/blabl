defmodule BlablWeb.MessengerController do
  use BlablWeb, :controller

  import Phoenix.LiveView.Controller

  def index(conn, _params) do
    live_render(conn, BlablWeb.MessengerLive, session: %{})
  end
end