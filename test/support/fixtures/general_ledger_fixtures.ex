defmodule AuroraUixDemo.GeneralLedgerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AuroraUixDemo.GeneralLedger` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        description: "some description",
        number: "some number"
      })
      |> AuroraUixDemo.GeneralLedger.create_account()

    account
  end
end
