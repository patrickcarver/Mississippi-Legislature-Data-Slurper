defmodule MsLegisTest do
  use ExUnit.Case
  doctest MsLegis

  alias MsLegis.{
    GetXmlFromUrl,
    XmlMetadata,
    Urls
  }

  setup_all do
    {:ok, []}
  end

  test "retrieve 122 house member links" do
    list = GetXmlFromUrl.apply(Urls.house_link)
            |> MsLegis.get_list_xml(XmlMetadata.list)

    assert Enum.count(list) == 122
  end
end
