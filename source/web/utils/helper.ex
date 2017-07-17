defmodule Utils.Helper do
  alias Phoenix.Controller
  import Fusun.Gettext

  def is_valid_email(email) do
    Regex.run(~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, email)
  end

  def request_path_with_param(conn) do
    conn.request_path <> "?" <> conn.query_string
  end

  def is_active_route(route, string) do
    String.contains?(route, string)
  end

  def get_option(options, option_key) do
    {option, key} = Enum.find(options, {(gettext "None"), nil}, fn({value, key}) -> key == option_key end)
    option
  end
end
