defmodule Fusun.Model.Image do
  use Fusun.Web, :model
  
  schema "images" do    
    # Fields
    field :name, :string
    field :path, :string
    field :description, :string
    timestamps

    # Relationship
    belongs_to :user, Fusun.Model.User, foreign_key: :user_id
    has_one :product_image, Fusun.Model.ProductImage
    has_one :product, through: [:product_image, :product]
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