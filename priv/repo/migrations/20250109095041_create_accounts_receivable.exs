defmodule AuroraUixDemo.Repo.Migrations.CreateAccountsReceivable do
  use Ecto.Migration

  def change do
    create table(:account_receivables, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :description, :string
      add :amount, :numeric, precision: 12, scale: 2, default: 0.0

      timestamps(type: :utc_datetime)
    end
  end
end
