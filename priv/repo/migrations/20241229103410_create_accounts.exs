defmodule AuroraUixDemo.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :number, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
