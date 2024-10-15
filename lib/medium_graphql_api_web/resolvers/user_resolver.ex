defmodule MediumGraphqlApiWeb.Resolvers.UserResolver do
  alias MediumGraphqlApi.Accounts

  def users(_parent, _args, _resolution) do
    {:ok, Accounts.list_users()}
  end

  def create_user(_parent, %{user_input: user_input}, _resolution) do
    Accounts.create_user(user_input)
  end
end
