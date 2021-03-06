defmodule Elixre.RegexController do
  @moduledoc """
  Responsible for running regexes against test strings.
  """

  use Elixre.Web, :controller

  import Elixre.Regex, only: [test: 3]

  def index(conn, params = %{"regex" => regex, "subject" => subject}) do
    modifiers = params["modifiers"] || ""
    render conn, "result.json", data: test(regex, subject, modifiers)
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
    |> case do
      ~w(regex)   -> ~w(subject[])
      ~w(subject) -> ~w(regex)
      _           -> ~w(regex subject[])
    end

    %{"missing params": params}
  end
end
