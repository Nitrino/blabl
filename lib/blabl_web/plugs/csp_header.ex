defmodule BlablWeb.Plugs.CSPHeader do
  @moduledoc """
  Plug to set Content-Security-Policy with websocket endpoints
  """

  @behaviour Plug

  alias Phoenix.Controller
  alias Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> Conn.put_resp_header("content-security-policy", csp(conn))
  end

  defp csp(conn) do
    "default-src 'self'; \
    connect-src 'self' #{ws_url(conn)} #{ws_url(conn, "wss")}; \
    script-src 'self' 'unsafe-eval';\
    style-src 'self' 'unsafe-inline'; \
    img-src 'self'; \
    font-src 'self'; \
    frame-src 'self'; \
    object-src 'none';"
  end

  defp ws_url(conn, protocol \\ "ws") do
    endpoint = Controller.endpoint_module(conn)
    %{endpoint.struct_url | scheme: protocol} |> URI.to_string()
  end
end
