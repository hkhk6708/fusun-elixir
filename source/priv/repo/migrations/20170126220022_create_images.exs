defmodule Fusun.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
  	create table(:images) do
  	  add :name, :text
  	  add :path, :text
      add :description, :text

      add :user_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end
  end

  def down do
    drop table(:images)
  end
end
