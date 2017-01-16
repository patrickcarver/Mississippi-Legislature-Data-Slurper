defmodule MsLegisTest do
  use ExUnit.Case
  doctest MsLegis



  setup_all do

    {:ok, []}
  end

  test "remove white space" do
    original = "Hello \tWorld\r\n"
    cleaned = MsLegis.CleanXml.remove_whitespace(original)

    assert cleaned == "Hello World"
  end

  test "remove bad quotes" do
    original = <<147>> <> "Hello World" <> <<148>>
    cleaned = MsLegis.CleanXml.remove_bad_quotes(original)

    assert cleaned == "Hello World"
  end

  test "retrieve 122 house member links" do
    list = MsLegis.GetXmlFromUrl.apply(MsLegis.Urls.house_link)
            |> MsLegis.get_list_xml(MsLegis.XmlMetadata.list)

    assert Enum.count(list) == 122
  end


end
