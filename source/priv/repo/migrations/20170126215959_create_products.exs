defmodule Fusun.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
  	create table(:products) do
      add :name, :string
      add :type, :string
      add :description, :text
      add :price, :float
      add :provider, :text
      add :spec, :text
      add :size, :text
      add :code, :text
      add :v_number, :text
      add :radius, :text
      add :position, :text
      add :status, :integer, default: 0

      add :user_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end
  end

  def down do
    drop table(:products)
  end
end
