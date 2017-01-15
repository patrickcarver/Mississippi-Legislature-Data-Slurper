defmodule MsLegisTest do
  use ExUnit.Case
  doctest MsLegis



  test "test chair link" do
    import MsLegis.XQuery

    xquery = %MsLegis.XQuery{}
    assert xquery.chair_link == "//CHAIR_LINK/text()"
  end
end
