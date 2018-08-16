defmodule ConvallariaWeb.Router do
  use ConvallariaWeb, :router

  # 游客
  pipeline :tourist_user do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {ConvallariaWeb.LayoutView, :tourist_user}
  end

  # 注册登录用户
  pipeline :authenticated_user do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {ConvallariaWeb.LayoutView, :authenticated_user}
    plug ConvallariaWeb.Plugs.AuthenticatedUser
  end

  # 超级管理员
  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {ConvallariaWeb.LayoutView, :admin}
    plug ConvallariaWeb.Plugs.AdminUser
  end

  # 游客
  pipeline :tourist_api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  # 注册登录用户
  pipeline :authenticated_api do
    plug :accepts, ["json"]
    plug ConvallariaWeb.Plugs.AuthenticatedApi
  end

  scope "/", ConvallariaWeb do
    pipe_through :tourist_user # Use the default browser stack

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/contact", PageController, :contact

    get "/login", SessionController, :new
    post "/login", SessionController, :login, as: :login
    get "/logout", SessionController, :delete, as: :logout

    scope "/u" do
      pipe_through :authenticated_user # Use the default browser stack

      get "/", UserController, :dashboard
      resources "/users", UserController, singleton: true do
        get "/profile", UserController, :profile, as: :profile
      end

      resources "/products", ProductController
      resources "/devices", DeviceController

    end

  end

  scope "/admin", ConvallariaWeb.Admin, as: :admin do
    pipe_through :admin

    get "/", PageController, :index
    resources "/users", UserController
    resources "/verify_codes", VerifyCodeController
    resources "/products", ProductController
    resources "/devices", DeviceController
    resources "/extinguisher_items", ExtinguisherItemController
    resources "/deals", DealController

    resources "/share_gallerys", ShareGalleryController
    resources "/account_avatars", AccountAvatarController

    scope "/" do
      get "/visual_iot", VisualController, :visual_iot
      # get "/visual_iot", VisualController, :visual_iot

    end

    scope "/setting" do
      get "/account", SettingController, :account
      get "/password", SettingController, :password
      get "/profile", SettingController, :profile
      get "/reward", SettingController, :reward
      put "/change", SettingController, :change
    end

  end

  scope "/api", ConvallariaWeb.Api, as: :api do
    pipe_through :tourist_api

    post "/sign_up", RegistrationController, :register, as: :sign_up
    post "/sign_in", SessionController, :login, as: :sign_in
    post "/send_code", VerifyCodeController, :send_code, as: :send_code

    scope "/" do
      pipe_through :authenticated_api

      resources "/users", UserController
      resources "/products", ProductController
      resources "/devices", DeviceController
      resources "/extinguisher_items", ExtinguisherItemController
      resources "/deals", DealController
      post "/gallerys", GalleryController, :create

    end
    
  end



  # Other scopes may use custom stacks.
  # scope "/api", ConvallariaWeb do
  #   pipe_through :api
  # end
end
