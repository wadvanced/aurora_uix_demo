defmodule AuroraUixDemo.GeneralLedger.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gl_transactions" do
    field :transaction_date, :date  # Date of transaction
    field :reference, :string       # Reference number (invoice, receipt, etc.)
    field :description, :string     # Transaction description
    field :amount, :decimal         # Transaction amount
    field :currency, :string        # ISO currency code
    field :transaction_type, :string # "debit" or "credit"

    belongs_to :account, AuroraUixDemo.GeneralLedger.Account

    timestamps()
  end

  @doc false
  def changeset(gl_transaction, attrs) do
    gl_transaction
    |> cast(attrs, [
      :transaction_date, :reference, :description, :amount,
      :currency, :transaction_type, :gl_account_id
    ])
    |> validate_required([
      :transaction_date, :amount, :transaction_type, :gl_account_id
    ])
    |> validate_inclusion(:transaction_type, ["debit", "credit"])
    |> validate_format(:currency, ~r/^[A-Z]{3}$/, message: "must be a valid ISO currency code")
    |> assoc_constraint(:gl_account)
  end
end