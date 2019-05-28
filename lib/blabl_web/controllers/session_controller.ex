defmodule BlablWeb.SessionController do
  use BlablWeb, :controller

  alias Blabl.Accounts
  alias Blabl.Auth
  alias Blabl.Auth.Guardian
  alias Blabl.Schema.User

  def new(conn, _) do
    changeset = Accounts.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: Routes.messenger_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def join(conn, _) do
    changeset = Accounts.change_user(%User{})
    render(conn, "join.html", changeset: changeset, action: Routes.session_path(conn, :sign_up))
  end

  def sign_up(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: Routes.messenger_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"login" => login, "password" => password}}) do
    Auth.authenticate_user(login, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.messenger_path(conn, :index))
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
