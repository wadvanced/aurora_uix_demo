defmodule AuroraUixDemoWeb.Router do
  use AuroraUixDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AuroraUixDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuroraUixDemoWeb do
    pipe_through :browser

    get "/", PageController, :home

    ## Uix live
    live "/gl_accounts", Aurora.GeneralLedger.Account.Index, :index
    live "/gl_accounts/new", Aurora.GeneralLedger.Account.Index, :new
    live "/gl_accounts/:id/edit", Aurora.GeneralLedger.Account.Index, :edit

    live "/gl_accounts/:id", Aurora.GeneralLedger.Account.Show, :show
    live "/gl_accounts/:id/show/edit", Aurora.GeneralLedger.Account.Show, :edit

    ## Normal live
    live "/accounts", AccountLive.Index, :index
    live "/accounts/new", AccountLive.Index, :new
    live "/accounts/:id/edit", AccountLive.Index, :edit

    live "/accounts/:id", AccountLive.Show, :show
    live "/accounts/:id/show/edit", AccountLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", AuroraUixDemoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:aurora_uix_demo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AuroraUixDemoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
