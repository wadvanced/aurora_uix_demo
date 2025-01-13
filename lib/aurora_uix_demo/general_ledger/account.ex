defmodule AuroraUixDemo.GeneralLedger.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias AuroraUixDemo.GeneralLedger.AccountReceivable

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "accounts" do
    field :description, :string
    field :number, :string

    timestamps(type: :utc_datetime)
    has_many :account_receivables, AccountReceivable
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:number, :description])
    |> validate_required([:number, :description])
  end
end
