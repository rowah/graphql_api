defmodule MediumGraphqlApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MediumGraphqlApi.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some@email",
        first_name: "some first_name",
        password: "some password",
        password_confirmation: "some password",
        last_name: "some last_name",
        role: "some role"
      })
      |> MediumGraphqlApi.Accounts.create_user()

    user
  end
end
