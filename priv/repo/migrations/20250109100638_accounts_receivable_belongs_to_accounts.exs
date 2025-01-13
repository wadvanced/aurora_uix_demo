defmodule AuroraUixDemo.Repo.Migrations.AccountsReceivableBelongsToAccounts do
  use Ecto.Migration

  def change do
    alter table(:account_receivables) do
      add :account_id, references(:accounts, type: :uuid)
    end
  end
end
