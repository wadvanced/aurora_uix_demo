defmodule AuroraUixDemoWeb.AccountLiveTest do
  use AuroraUixDemoWeb.ConnCase

  import Phoenix.LiveViewTest
  import AuroraUixDemo.GeneralLedgerFixtures

  @create_attrs %{description: "some description", number: "some number"}
  @update_attrs %{description: "some updated description", number: "some updated number"}
  @invalid_attrs %{description: nil, number: nil}

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end

  describe "Index" do
    setup [:create_account]

    test "lists all accounts", %{conn: conn, account: account} do
      {:ok, _index_live, html} = live(conn, ~p"/accounts")

      assert html =~ "Listing Accounts"
      assert html =~ account.description
    end

    test "saves new account", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/accounts")

      assert index_live |> element("a", "New Account") |> render_click() =~
               "New Account"

      assert_patch(index_live, ~p"/accounts/new")

      assert index_live
             |> form("#account-form", account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#account-form", account: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/accounts")

      html = render(index_live)
      assert html =~ "Account created successfully"
      assert html =~ "some description"
    end

    test "updates account in listing", %{conn: conn, account: account} do
      {:ok, index_live, _html} = live(conn, ~p"/accounts")

      assert index_live |> element("#accounts-#{account.id} a", "Edit") |> render_click() =~
               "Edit Account"

      assert_patch(index_live, ~p"/accounts/#{account}/edit")

      assert index_live
             |> form("#account-form", account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#account-form", account: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/accounts")

      html = render(index_live)
      assert html =~ "Account updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes account in listing", %{conn: conn, account: account} do
      {:ok, index_live, _html} = live(conn, ~p"/accounts")

      assert index_live |> element("#accounts-#{account.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#accounts-#{account.id}")
    end
  end

  describe "Show" do
    setup [:create_account]

    test "displays account", %{conn: conn, account: account} do
      {:ok, _show_live, html} = live(conn, ~p"/accounts/#{account}")

      assert html =~ "Show Account"
      assert html =~ account.description
    end

    test "updates account within modal", %{conn: conn, account: account} do
      {:ok, show_live, _html} = live(conn, ~p"/accounts/#{account}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Account"

      assert_patch(show_live, ~p"/accounts/#{account}/show/edit")

      assert show_live
             |> form("#account-form", account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#account-form", account: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/accounts/#{account}")

      html = render(show_live)
      assert html =~ "Account updated successfully"
      assert html =~ "some updated description"
    end
  end
end
