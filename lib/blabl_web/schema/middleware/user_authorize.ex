defmodule BlablWeb.Schema.Middleware.UserAuthorize do
  @moduledoc """
  Middleware for check user autorization.
  Used in the scheme for requests that require authorization.
  """
  @behaviour Absinthe.Middleware

  def call(resolution, _opts) do
    case resolution.context do
      %{current_user: _} ->
        resolution

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "Not Authorized"})
    end
  end
end
