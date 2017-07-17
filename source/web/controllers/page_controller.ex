defmodule Fusun.PageController do
  use Fusun.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def change_language(conn, %{"lang" => lang, "path" => path}) do
    # update session locale
    conn
    |> Plug.Locale.set_locale(lang)
    |> redirect(to: path)
  end
end
