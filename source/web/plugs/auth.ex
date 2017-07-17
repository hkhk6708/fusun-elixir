defmodule Plug.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import Ecto.Query
  import Fusun.Gettext
  import Comeonin.Bcrypt, only: [checkpw: 2]
  alias Fusun.Repo
  alias Fusun.Model.User

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && Repo.get_by(User, id: user_id)
    assign(conn, :current_user, user)
  end

  def login_user(conn) do
    Dict.get(conn.assigns, :current_user, nil)
  end

  # login action, return conn with assigned user and session information
  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> put_session(:user_role, user.role)
    |> configure_session(renew: true)
  end

  # logout action
  def logout(conn) do
    conn
    |> clear_session
    |> configure_session(drop: true)
    |> halt()
  end

  def check_by_username_and_pass(username, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = User
    |> where([u], u.email == ^username or u.username == ^username)
    |> repo.one

    cond do
      is_nil(user) ->
        {:error, gettext "Email or Password is incorrect"}
      !checkpw(given_pass, user.password) ->
        {:error, gettext "Email or Password is incorrect"}
      user.status != 1 ->
        {:error, gettext "Please activate your account"}
      true ->
        {:ok, user}
    end
  end

  # sudo admin login
  # def sudo_login(conn, params, user_id, opts) do
  #   repo = Keyword.fetch!(opts, :repo)
  #   adminUser = repo.get_by(User, [email: params["email"], role: User.role_admin])
  #   user = repo.get_by(User, id: user_id)

  #   cond do
  #     is_nil(user) ->
  #       {:error, gettext "Target User not found"}
  #     is_nil(adminUser) ->
  #       {:error, gettext "Admin not found"}
  #     !checkpw(params["password"], adminUser.password_hash) ->
  #       {:error, gettext "Admin Email or Password is incorrect"}
  #     true ->
  #       {:ok, login(conn, user)}
  #   end
  # end
end
