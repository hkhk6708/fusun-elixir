defmodule Fusun.Model.ProductImage do
  use Fusun.Web, :model
  
  schema "product_images" do    
    # Fields
    timestamps

    # Relationship
    belongs_to :product, Fusun.Model.Product, foreign_key: :product_id
    belongs_to :image, Fusun.Model.Image, foreign_key: :image_id
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
end