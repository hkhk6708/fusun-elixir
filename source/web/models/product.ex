defmodule Fusun.Model.Product do
  use Fusun.Web, :model
  
  schema "products" do    
    # Fields
    field :name, :string
    field :type, :string
    field :description, :string
    field :price, :float
    field :provider, :string
    field :spec, :string
    field :size, :string
    field :code, :string
    field :v_number, :string
    field :radius, :string
    field :position, :string
    timestamps

    # Relationship
    belongs_to :user, Fusun.Model.User, foreign_key: :user_id
    has_many :product_images, Fusun.Model.ProductImage
    has_many :images, through: [:product_images, :image]
    has_many :inventories, Fusun.Model.ProductInventory
  end

  # Static Constants
  @required_fields ~w()
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def get_product(id) do
    product = __MODULE__
    |> query_preload_iventories
    |> query_preload_images
    |> Repo.get_by(id: id)
  end

  def get_products(type) do
    products = __MODULE__
    |> query_by_type(type)
    |> query_preload_iventories
    |> Repo.all
  end

  def query_preload_images(query \\ __MODULE__) do
    from p in query, preload: [:images]
  end

  def query_preload_iventories(query \\ __MODULE__) do
    from p in query, preload: [:inventories]
  end

  def query_by_id(query, id) do
    from(p in query, where: p.id == ^id)
  end

  def query_by_type(query, type) do
    from(p in query, where: p.type == ^type)
  end
end
