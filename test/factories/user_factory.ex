defmodule Blabl.UserFactory do
  @moduledoc """
  Factory for User schema
  """
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Blabl.Accounts.User{
          login: Faker.Pokemon.name(),
          email: Faker.Internet.email(),
          # credo:disable-for-next-line
          phone: Faker.Phone.EnUs.phone(),
        }
      end

      def with_password(%Blabl.Accounts.User{} = user, password \\ Faker.String.base64()) do
        %{user | password: password, password_hash: Comeonin.Bcrypt.hashpwsalt(password)}
      end
    end
  end
end
