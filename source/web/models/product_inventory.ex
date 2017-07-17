defmodule Fusun.Model.ProductInventory do
  use Fusun.Web, :model
  
  schema "product_inventory" do    
    # Fields
    field :change, :integer, default: 0
    field :description, :string
    
    timestamps

    # Relationship
    belongs_to :user, Fusun.Model.User, foreign_key: :user_id
    belongs_to :product, Fusun.Model.Product, foreign_key: :product_id
  end

  # Static Constants
  @required_fields ~w(change product_id)
  @optional_fields ~w(description)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end