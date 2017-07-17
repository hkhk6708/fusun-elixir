defmodule Fusun.SessionController do
  use Fusun.Web, :controller

  plug :put_layout, "app.html"

  # defp after_login_page_path(conn) do
  # 	app_path(conn, :index)
  #   # role = get_session(conn, :user_role)

  #   # case role do
  #   #   "admin" -> admin_page_path(conn, :index)
  #   #   "operator" -> operator_page_path(conn, :index)
  #   #   "hotel_user" -> hotel_user_page_path(conn, :index)
  #   #   "travel_agent" -> "/"
  #   #   "vendor" -> vendor_page_path(conn, :index)
  #   #    _ -> "/"
  #   # end
  # end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Plug.Auth.check_by_username_and_pass(username, password, repo: Repo) do
      {:ok, user} ->
        conn = conn 
        |> Plug.Auth.login(user)
        |> redirect(to: admin_dashboard_path(conn, :index))
      {:error, message} ->
        conn
        |> put_flash(:login_error, message)
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
  	conn
  	|> Plug.Auth.logout()
  	|> put_flash(:info, "Signed out successfully!")
  	|> redirect(to: session_path(conn, :new))
  end
end
