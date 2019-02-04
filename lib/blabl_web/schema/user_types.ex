defmodule BlablWeb.Schema.UserTypes do
  @moduledoc """
    GraphQL types for User
  """

  use Absinthe.Schema.Notation

  object :user do
    field(:id, :id)
    field(:login, :string)
    field(:email, :string)
    field(:phone, :string)
  end

  input_object :user_input do
    field(:login, non_null(:string))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:phone, :string)
  end

  object :session do
    field(:token, :string)
    field(:user, :user)
  end
end
