defmodule AuroraUixDemo.Repo.Migrations.CreateCustomer do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :email, :string
      add :password, :string

      timestamps(type: :utc_datetime)
    end
  end
end
