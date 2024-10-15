defmodule MediumGraphqlApiWeb.Accounts.Session do
  alias MediumGraphqlApi.Repo
  alias MediumGraphqlApi.Accounts.User

  def authenticate_user(args) do
    user = Repo.get_by(User, email: String.downcase(args.email))

    case check_password(user, args) do
      true -> {:ok, user}
      _ -> {:error, "Wrong email or password"}
    end
  end

  defp check_password(user, args) do
    case user do
      # TODO: find a way to prevent brute force with throttling login attempts
      nil -> false
      _user -> Bcrypt.verify_pass(args.password, user.hashed_password)
    end
  end
end
