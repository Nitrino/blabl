defmodule BlablWeb.Router do
  use BlablWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(BlablWeb.Plugs.CSPHeader)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlablWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug,
      schema: BlablWeb.Schema,
      json_codec: Jason
    )

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: BlablWeb.Schema,
      json_codec: Jason,
      context: %{pubsub: BlablWeb.Endpoint}
    )
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlablWeb do
  #   pipe_through :api
  # end
end
