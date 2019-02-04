defmodule Blabl.TestHelpers do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      def auth_user(conn, user) do
        {:ok, token, _} = Blabl.Guardian.encode_and_sign(user)
        put_req_header(conn, "authorization", "Bearer #{token}")
      end
    end
  end
end
