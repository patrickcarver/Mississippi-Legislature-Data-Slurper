defmodule MsLegisTest do
  use ExUnit.Case
  doctest MsLegis

  alias MsLegis.{CleanXml, GetXmlFromUrl, XmlMetadata, Urls}

  setup_all do
    {:ok, []}
  end

  test "remove white space" do
    original = "Hello \tWorld\r\n"
    cleaned = CleanXml.remove_whitespace(original)

    assert cleaned == "Hello World"
  end

  test "remove bad quotes" do
    original = <<147>> <> "Hello World" <> <<148>>
    cleaned = CleanXml.remove_bad_quotes(original)

    assert cleaned == "Hello World"
  end

  test "retrieve 122 house member links" do
    list = GetXmlFromUrl.apply(Urls.house_link)
            |> MsLegis.get_list_xml(XmlMetadata.list)

    assert Enum.count(list) == 122
  end
end
