defmodule Fusun.Repo.Migrations.CreateProductIventory do
  use Ecto.Migration

  def change do
  	create table(:product_inventory) do
  	  add :change, :integer, default: 0
      add :description, :text

      add :user_id, references(:users, on_delete: :nilify_all)
      add :product_id, references(:products, on_delete: :delete_all)

      timestamps()
    end
  end

  def down do
    drop table(:product_inventory)
  end
end
