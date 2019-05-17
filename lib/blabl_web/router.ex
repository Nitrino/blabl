defmodule BlablWeb.Router do
  use BlablWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(Phoenix.LiveView.Flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(BlablWeb.Plugs.CSPHeader)
  end

  pipeline :auth do
    plug Blabl.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BlablWeb do
    pipe_through [:browser, :auth]

    get "/", SessionController, :new

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    post "/logout", SessionController, :logout
  end

  # Logged in scope
  scope "/", BlablWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/secret", PageController, :secret
    get "/messenger", MessengerController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlablWeb do
  #   pipe_through :api
  # end
end
