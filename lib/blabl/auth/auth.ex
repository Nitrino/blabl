defmodule Blabl.Auth do
  @moduledoc """
  Module for User Authenticate
  """

  import Ecto.Query

  alias Blabl.Repo
  alias Blabl.Schema.User

  def authenticate_user(login, password) do
    query = from u in User, where: u.login == ^login

    Repo.one(query)
    |> check_password(password)
  end

  defp check_password(nil, _), do: {:error, "Incorrect login or password"}

  defp check_password(user, password) do
    case Bcrypt.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, "Incorrect login or password"}
    end
  end
end
