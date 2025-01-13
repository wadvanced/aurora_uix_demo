defmodule AuroraUixDemo.GeneralLedger.AccountReceivable do
  use Ecto.Schema
  import Ecto.Changeset

  alias AuroraUixDemo.GeneralLedger.Account

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "account_receivables" do
    field :description, :string
    field :amount, :float

    timestamps(type: :utc_datetime)

    belongs_to :account, Account
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:description, :amount])
    |> validate_required([:description, :amount])
  end
end
