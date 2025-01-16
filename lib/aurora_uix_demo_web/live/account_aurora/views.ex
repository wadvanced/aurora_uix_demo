defmodule AuroraUixDemoWeb.AccountLive.Aurora.Views do
  use AuroraUixWeb.Uix
  alias AuroraUixDemo.GeneralLedger
  alias AuroraUixDemo.GeneralLedger.Account

  module(AuroraUixDemoWeb, GeneralLedger, Account, :index,
    fields: [AuroraUix.Field.new(field: :number), AuroraUix.Field.new(field: :description)]
  )

end
