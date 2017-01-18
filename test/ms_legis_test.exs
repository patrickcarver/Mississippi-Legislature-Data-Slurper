defmodule MsLegisTest do
  use ExUnit.Case
  doctest MsLegis

  alias MsLegis.{ CleanXml, GetXmlFromUrl, ProcessMemberName, XmlMetadata, Urls }

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

  test "remove punctuation from Willie J. Perkins, Sr." do
    original = "Willie J. Perkins, Sr."
    cleaned = ProcessMemberName.remove_punctuation(original)

    assert cleaned == "Willie J Perkins Sr"
  end

  test "get suffix from Willie J. Perkins, Sr." do
    assert ProcessMemberName.get_suffix("Willie J Perkins Sr") == "Sr"
  end

  test "get suffix from Sam C. Mims, V" do
    assert ProcessMemberName.get_suffix("Sam C Mims V") == "V"
  end

  test "get suffix from Henry Zuber III" do
    assert ProcessMemberName.get_suffix("Henry Zuber III") == "III"
  end

  test "get suffix from Mark Tullos" do
    assert ProcessMemberName.get_suffix("Mark Tullos") == ""
  end

  test "get suffix from Edward Blackmon, Jr." do
    assert ProcessMemberName.get_suffix("Edward Blackmon Jr") == "Jr"
  end

end
