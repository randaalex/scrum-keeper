defmodule ScrumKeeper.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/webhook" do
    send_resp(conn, 200, "hello world")
  end

  match _ do
    send_resp(conn, 404, "not_found")
  end
end
