defmodule Fusun.Router do
  use Fusun.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plug.Locale
    plug Plug.Auth, repo: Fusun.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Access Control
  pipeline :access_control do
    plug Plug.AccessControl
  end
  
  # Backend Layout
  pipeline :backend_layout do
    plug :put_layout, {Fusun.LayoutView, :backend}
  end

  scope "/", Fusun do
    pipe_through :browser # Use the default browser stack

    # Login Session
    get "/", SessionController, :new
    get "/login", SessionController, :new
    post "/login",  SessionController, :create
    get "/logout", SessionController, :delete

    # Locale
    get "/change_language", PageController, :change_language

    # Access Control (must have user login session)
    scope "/" do
      pipe_through [:access_control]
      
      # LinkPub Admin Only
      scope "/admin", Admin, as: :admin do
        pipe_through [:backend_layout]
        
        get "/", DashboardController, :index
        get "/tires", ProductController, :tires
        get "/wheels", ProductController, :wheels
        get "/product/management/:id", ProductController, :management
        post "/product/update_inventory/:id", ProductController, :update_inventory
        resources "/product", ProductController, except: [:show]
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Fusun do
  #   pipe_through :api
  # end
end
