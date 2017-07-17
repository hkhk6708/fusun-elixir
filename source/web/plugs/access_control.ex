defmodule Plug.AccessControl do
  import Plug.Conn
  import Phoenix.Controller
  import Fusun.Gettext

  def init(opts) do 
  end

  def call(conn, _) do
    user = Plug.Auth.login_user(conn)
    case check_access_control(user) do
      {:error, message} -> 
        conn
        |> put_flash(:login_error, message)
        |> redirect(to: Fusun.Router.Helpers.session_path(conn, :new))
        |> halt()
      _ ->
        conn
    end
  end

  defp check_access_control(nil), do: {:error, gettext "Please login first."}
  defp check_access_control(user) do
    cond do
      user.status != 1 ->
        {:error, gettext "Your account has been deactivated. Please contact administrator for more information."}
      true ->
        {:ok}
    end
  end
end
