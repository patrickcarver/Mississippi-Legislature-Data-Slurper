defmodule MsLegis.XQueryResultParser do
  @callback get_text(String.t, String.t) :: String.t
  @callback get_list(String.t, String.t) :: list(String.t)
end
