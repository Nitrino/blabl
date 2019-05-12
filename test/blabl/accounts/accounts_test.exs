defmodule Blabl.AccountsTest do
  use Blabl.DataCase

  alias Blabl.Accounts

  describe "users" do
    alias Blabl.Schema.User

    @invalid_attrs Map.new(params_for(:user), fn {k, _} -> {k, nil} end)

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      params = params_for(:user, password: Faker.String.base64())
      assert {:ok, %User{} = user} = Accounts.create_user(params)
      assert user.email == params[:email]
      assert user.login == params[:login]
      assert user.phone == params[:phone]
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      params = params_for(:user, password: Faker.String.base64())
      assert {:ok, %User{} = user} = Accounts.update_user(user, params)
      assert user.email == params[:email]
      assert user.login == params[:login]
      assert user.phone == params[:phone]
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
