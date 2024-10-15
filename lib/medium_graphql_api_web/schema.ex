defmodule MediumGraphqlApiWeb.Schema do
  use Absinthe.Schema

  alias MediumGraphqlApiWeb.Resolvers

  import_types(MediumGraphqlApiWeb.Schema.Types)

  query do
    @desc "Get all users"
    field :users, list_of(:user_type) do
      resolve(&Resolvers.UserResolver.users/3)
    end
  end

  mutation do
    @desc "Create a new user"
    field :create_user, :user_type do
      arg(:user_input, non_null(:user_input_type))
      resolve(&Resolvers.UserResolver.create_user/3)
    end

    @desc "Login a user and return a JWT token"
    field :login_user, :session_type do
      arg(:login_input, non_null(:session_input_type))
      resolve(&Resolvers.SessionResolver.login_user/3)
    end
  end

  # subscription do
  # end
end
