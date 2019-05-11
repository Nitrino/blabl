defmodule Blabl.Auth.Pipeline do
  @moduledoc """
  Authentication pipeline for routers
  """

  use Guardian.Plug.Pipeline,
    otp_app: :blabl,
    error_handler: Blabl.Auth.ErrorHandler,
    module: Blabl.Auth.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
