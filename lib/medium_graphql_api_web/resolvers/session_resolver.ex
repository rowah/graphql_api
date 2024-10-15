defmodule MediumGraphqlApiWeb.Resolvers.SessionResolver do
  alias MediumGraphqlApiWeb.Accounts.Session
  alias MediumGraphqlApi.Guardian

  def login_user(_parent, %{login_input: login_input}, _resolution) do
    #  is the user in our database
    # if the user exists and the password is correct we return a token and the user
    with {:ok, user} <- Session.authenticate_user(login_input),
         {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end
end
