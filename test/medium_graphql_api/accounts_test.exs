defmodule MediumGraphqlApi.AccountsTest do
  use MediumGraphqlApi.DataCase

  alias MediumGraphqlApi.Accounts

  describe "users" do
    alias MediumGraphqlApi.Accounts.User

    import MediumGraphqlApi.AccountsFixtures

    @invalid_attrs %{role: nil, first_name: nil, last_name: nil, email: nil, hashed_password: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      users = Accounts.list_users()
      assert length(users) == 1
      assert List.first(users).first_name == user.first_name
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        role: "some role",
        first_name: "some first_name",
        last_name: "some last_name",
        email: "some@email",
        password: "some password",
        password_confirmation: "some password"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.role == "some role"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.email == "some@email"
      refute user.hashed_password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        role: "some updated role",
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        email: "some@updatedemail",
        password: "somepassword",
        password_confirmation: "somepassword"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.role == "some updated role"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.email == "some@updatedemail"
      refute user.hashed_password == "somepassword"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user.email == Accounts.get_user!(user.id).email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
