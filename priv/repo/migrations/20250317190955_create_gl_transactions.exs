defmodule AuroraUixDemo.Repo.Migrations.CreateGlTransactions do
  use Ecto.Migration

  def change do
    create table(:gl_transactions) do
      add :transaction_date, :date, null: false
      add :reference, :string
      add :description, :string
      add :amount, :decimal, precision: 15, scale: 2, null: false
      add :currency, :string, default: "USD"
      add :transaction_type, :string, null: false # "debit" or "credit"
      add :account_id, references(:gl_accounts, on_delete: :restrict), null: false

      timestamps()
    end

    create index(:gl_transactions, [:account_id])
    create index(:gl_transactions, [:transaction_date])
  end
end
