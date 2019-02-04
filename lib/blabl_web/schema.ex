defmodule BlablWeb.Schema do
  @moduledoc """
  Main GraphQL schema module
  """

  use Absinthe.Schema

  alias BlablWeb.Resolvers.UsersResolver
  alias BlablWeb.Schema.Middleware

  import_types(__MODULE__.UserTypes)

  mutation do
    field :create_user, :user do
      arg(:input, non_null(:user_input))
      resolve(&UsersResolver.create_user/3)
    end

    field :login, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UsersResolver.login/3)
    end
  end

  # this is the query entry point to our app
  query do
  end
end
