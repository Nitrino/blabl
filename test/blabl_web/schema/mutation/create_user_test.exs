defmodule BlablWeb.Schema.Mutation.CreateUserTest do
  use BlablWeb.ConnCase, async: true

  @query """
    mutation ($user: UserInput!) {
      createUser(input: $user) {
        login
        email
        phone
      }
    }
  """

  test "createUser field creates an item" do
    params = params_for(:user, password: Faker.String.base64())

    conn = build_conn()
    conn = post(conn, "/api", query: @query, variables: %{"user" => params})

    assert json_response(conn, 200) == %{
             "data" => %{
               "createUser" => %{
                 "login" => params[:login],
                 "email" => params[:email],
                 "phone" => params[:phone]
               }
             }
           }
  end
end
