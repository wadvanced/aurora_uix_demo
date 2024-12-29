defmodule AuroraUixDemo.GeneralLedgerTest do
  use AuroraUixDemo.DataCase

  alias AuroraUixDemo.GeneralLedger

  describe "accounts" do
    alias AuroraUixDemo.GeneralLedger.Account

    import AuroraUixDemo.GeneralLedgerFixtures

    @invalid_attrs %{description: nil, number: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert GeneralLedger.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert GeneralLedger.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{description: "some description", number: "some number"}

      assert {:ok, %Account{} = account} = GeneralLedger.create_account(valid_attrs)
      assert account.description == "some description"
      assert account.number == "some number"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GeneralLedger.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{description: "some updated description", number: "some updated number"}

      assert {:ok, %Account{} = account} = GeneralLedger.update_account(account, update_attrs)
      assert account.description == "some updated description"
      assert account.number == "some updated number"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = GeneralLedger.update_account(account, @invalid_attrs)
      assert account == GeneralLedger.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = GeneralLedger.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> GeneralLedger.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = GeneralLedger.change_account(account)
    end
  end
end
