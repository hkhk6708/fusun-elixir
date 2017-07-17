defmodule Fusun.Admin.DashboardController do
  use Fusun.Web, :controller
  alias Fusun.Model.Product

  def index(conn, _params) do
  	tires = Product.get_products("tire")
  	wheels = Product.get_products("wheel")

    render(conn, "index.html", 
      tires: tires,
      wheels: wheels
    )
  end
end
