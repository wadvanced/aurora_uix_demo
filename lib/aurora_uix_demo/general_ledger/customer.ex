defmodule AuroraUixDemo.GeneralLedger.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :email, :string
    field :password, :string, redact: true

    timestamps(type: :utc_datetime)
  end

  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :password])
    |> validate_format(:email, ~r/@/)
  end
end
