defmodule AuroraUixDemo.Repo.Migrations.CreateGlAccount do
  use Ecto.Migration

  def change do
    create table(:gl_accounts) do
      add :code, :string, null: false
      add :name, :string, null: false
      add :description, :string
      add :account_type, :string, null: false # Asset, Liability, Equity, Revenue, Expense
      add :normal_balance, :string, null: false # "debit" or "credit"
      add :currency, :string, default: "USD"
      add :status, :string, default: "active" # Active, Inactive, Archived
      add :opening_balance, :decimal, precision: 15, scale: 2, default: 0.0
      add :current_balance, :decimal, precision: 15, scale: 2, default: 0.0
      add :notes, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:gl_accounts, [:code])
    create index(:gl_accounts, [:account_type])
    create index(:gl_accounts, [:status])  end
end
