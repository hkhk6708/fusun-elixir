defmodule Fusun.Admin.ProductController do
  use Fusun.Web, :controller
  alias Fusun.Model.Product
  alias Fusun.Model.ProductInventory

  # def index(conn, _params) do
  #   render conn, "index.html"
  # end

  def wheels(conn, _params) do
  	list(conn, "wheel")
  end

  def tires(conn, _params) do
  	list(conn, "tire")
  end

  def list(conn, type) do
  	products = Product.get_products(type)

    render(conn, "list.html", 
      products: products,
      type: type
    )
  end

  def new(conn, _params) do
    product_changeset = Product.changeset(%Product{})
    render(conn, "new.html",
      product_changeset: product_changeset
    )
  end

  def create(conn, %{"product" => product_params}) do
    
  end

  def management(conn, %{"id" => id}) do
    product = Product.get_product(id)
    inventory_changeset = ProductInventory.changeset(%ProductInventory{})
    render(conn, "management.html",
      product: product,
      inventory_changeset: inventory_changeset
    )
  end

  def update_inventory(conn, %{"id" => id, "product_inventory" => product_inventory_params}) do
    product = Product.get_product(id)
    inventory_changeset = ProductInventory.changeset(%ProductInventory{}, product_inventory_params)
    case Repo.insert(inventory_changeset) do
      {:ok, product_inventory} ->
        conn 
        |> redirect(to: admin_product_path(conn, :management, id))
      {:error, changeset} ->
        render(conn, "management.html",
          product: product,
          inventory_changeset: inventory_changeset
        )
    end
  end
end