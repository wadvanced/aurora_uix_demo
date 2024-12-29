defmodule AuroraUixDemoWeb.AccountLive.FormComponent do
  use AuroraUixDemoWeb, :live_component

  alias AuroraUixDemo.GeneralLedger

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage account records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="account-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:number]} type="text" label="Number" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Account</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{account: account} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(GeneralLedger.change_account(account))
     end)}
  end

  @impl true
  def handle_event("validate", %{"account" => account_params}, socket) do
    changeset = GeneralLedger.change_account(socket.assigns.account, account_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"account" => account_params}, socket) do
    save_account(socket, socket.assigns.action, account_params)
  end

  defp save_account(socket, :edit, account_params) do
    case GeneralLedger.update_account(socket.assigns.account, account_params) do
      {:ok, account} ->
        notify_parent({:saved, account})

        {:noreply,
         socket
         |> put_flash(:info, "Account updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_account(socket, :new, account_params) do
    case GeneralLedger.create_account(account_params) do
      {:ok, account} ->
        notify_parent({:saved, account})

        {:noreply,
         socket
         |> put_flash(:info, "Account created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
