defmodule AuroraUixDemo.GeneralLedger.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias AuroraUixDemo.GeneralLedger.AccountReceivable

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "gl_accounts" do
    field :code, :string          # Unique account code (e.g., "1000", "4001")
    field :name, :string          # Account name (e.g., "Cash", "Revenue")
    field :description, :string   # Longer description
    field :account_type, :string  # Asset, Liability, Equity, Revenue, Expense
    field :normal_balance, :string # "debit" or "credit"
    field :currency, :string       # ISO currency code (e.g., "USD", "EUR")
    field :status, :string         # Active, Inactive, Archived
    field :opening_balance, :decimal, default: 0.0
    field :current_balance, :decimal, default: 0.0
    field :notes, :string          # Additional remarks

    timestamps(type: :utc_datetime)
    has_many :transactions, Transactions
  end

  @doc false
  def changeset(gl_account, attrs) do
    gl_account
    |> cast(attrs, [
      :code, :name, :description, :account_type, :normal_balance,
      :currency, :status, :opening_balance, :current_balance,
      :notes
    ])
    |> validate_required([:code, :name, :account_type, :normal_balance, :status])
    |> validate_length(:code, min: 3, max: 10)
    |> validate_inclusion(:account_type, ["Asset", "Liability", "Equity", "Revenue", "Expense"])
    |> validate_inclusion(:normal_balance, ["debit", "credit"])
    |> validate_inclusion(:status, ["Active", "Inactive", "Archived"])
    |> validate_format(:currency, ~r/^[A-Z]{3}$/, message: "must be a valid ISO currency code")
    |> unique_constraint(:code)
  end
end

