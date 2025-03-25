defmodule AuroraUixDemoWeb.Aurora.GeneralLedger do
  use AuroraUixWeb.Uix
  alias AuroraUixDemo.GeneralLedger
  alias AuroraUixDemo.GeneralLedger.Account


  auix_resource_config :account, schema: Account, context: GeneralLedger

  auix_create_ui do
    edit_layout :account do
      inline [:code, :name]
      sections do
        section "Description" do
          stacked [:description, :account_type, :currency]
        end
        section "Balances" do
          inline [:opening_balance, :current_balance]
        end
      end
    end
  end
end
