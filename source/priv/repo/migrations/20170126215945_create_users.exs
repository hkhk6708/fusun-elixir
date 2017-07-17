defmodule Fusun.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
  	create table(:users) do
      add :email, :string
      add :username, :string
      add :phone, :string
      add :password, :string
      add :firstname, :string
      add :lastname, :string
      add :role, :string, default: "admin"
      add :status, :integer, default: 0

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end

  def down do
    drop index(:users, [:email])
    drop index(:users, [:username])
    drop table(:users)
  end
end
