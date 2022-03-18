defmodule TestingLiveViewWallabyWeb.PageController do
  use TestingLiveViewWallabyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
