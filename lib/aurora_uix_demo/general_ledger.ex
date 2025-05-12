defmodule AuroraUixDemo.GeneralLedger do
  @moduledoc """
  The GeneralLedger context.
  """

  use Aurora.Ctx
  alias AuroraUixDemo.GeneralLedger.Account

  ctx_register_schema(Account)

end
