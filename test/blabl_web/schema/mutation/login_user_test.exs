defmodule BlablWeb.Schema.Mutation.LoginUser do
  use BlablWeb.ConnCase, async: true

  @query """
  mutation ($email: String!, $password: String!) {
    login(email: $email, password: $password) {
      token
    }
  }
  """

  test "Creating an user session" do
    user = build(:user) |> with_password |> insert
    conn = build_conn()

    conn =
      post(conn, "/api", %{
        query: @query,
        variables: %{
          "email" => user.email,
          "password" => user.password
        }
      })

    assert %{
             "data" => %{
               "login" => %{
                 "token" => token
               }
             }
           } = json_response(conn, 200)

    assert {:ok, _} = Blabl.Guardian.decode_and_verify(token)
  end

  test "Creating an user session with incorrect password" do
    user = build(:user) |> with_password |> insert
    conn = build_conn()

    conn =
      post(conn, "/api", %{
        query: @query,
        variables: %{
          "email" => user.email,
          "password" => "incorrect_password"
        }
      })

    assert %{
             "errors" => [
               %{
                 "message" => "Incorrect login credentials"
               }
             ]
           } = json_response(conn, 200)
  end
end
