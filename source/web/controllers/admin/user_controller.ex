defmodule Fusun.Admin.ProductController do
  use Fusun.Web, :controller
  alias Fusun.Model.{User}

  def index(conn, _params) do
    render conn, "index.html"
  end
end