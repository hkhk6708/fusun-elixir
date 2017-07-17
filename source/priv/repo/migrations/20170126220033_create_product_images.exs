defmodule Fusun.Repo.Migrations.CreateProductImages do
  use Ecto.Migration

  def change do
  	create table(:product_images) do
  	  add :product_id, references(:products, on_delete: :delete_all)
  	  add :image_id, references(:images, on_delete: :delete_all)

      timestamps()
    end
  end

  def down do
    drop table(:images)
  end
end
