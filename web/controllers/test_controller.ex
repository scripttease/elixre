defmodule RegTest.TestController do
  use RegTest.Web, :controller

  plug :action


  def index(conn, %{"regex" => regex, "subject" => subject}) do
    render conn, "result.json", data: %{hello: "world"}
  end

  def index(conn, params) do
    conn
    |> put_status(400)
    |> render "result.json", data: %{error: missing(params)}
  end

  defp missing(params) do
    params = params
    |> Dict.keys
    |> Enum.filter(&(&1 == "regex" or &1 == "subject"))

    params = case params do
      ~w(regex)   -> ~w(subject)
      ~w(subject) -> ~w(regex)
      _           -> ~w(regex subject)
    end

    %{"missing params": params}
  end
end
