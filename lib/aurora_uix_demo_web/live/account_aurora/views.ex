defmodule AuroraUixDemoWeb.AccountLive.Aurora.Views do
  use AuroraUixWeb.Uix
  alias AuroraUixDemo.GeneralLedger
  alias AuroraUixDemo.GeneralLedger.Account


  auix_resource_config :account, schema: Account, context: GeneralLedger
  auix_create_ui()

end
