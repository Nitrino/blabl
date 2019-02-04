defmodule BlablWeb.Resolvers.UsersResolver do
  @moduledoc """
  Resolver for User queries
  """
  alias Blabl.Accounts

  def all_users(_root, _args, _info) do
    users = Accounts.list_users()
    {:ok, users}
  end

  def create_user(_root, %{input: params}, _info) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        {:ok, user}

      _error ->
        {:error, "Could not create user"}
    end
  end

  def login(_root, %{email: email, password: password}, _info) do
    with {:ok, user} <- Accounts.login_with_email_password(email, password),
         {:ok, token, _} <- Blabl.Guardian.encode_and_sign(user) do
      {:ok, %{token: token, user: user}}
    end
  end
end
