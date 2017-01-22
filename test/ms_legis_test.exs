defmodule MsLegisTest do
  use ExUnit.Case
  doctest MsLegis

  alias MsLegis.{
    CleanXml,
    GetXmlFromUrl,
    MemberName,
    ProcessMemberName,
    XmlMetadata,
    Urls
  }

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

  test "is Sr suffix?" do
    assert ProcessMemberName.is_suffix?("Sr")
  end

  test "is V suffix?" do
    assert ProcessMemberName.is_suffix?("V")
  end

  test "is III suffix?" do
    assert ProcessMemberName.is_suffix?("III")
  end

  test "is Tullos suffix?" do
    refute ProcessMemberName.is_suffix?("Tullos")
  end

  test "create MemberName struct for Willie J. Perkins, Sr., get first name" do
    member_struct = ProcessMemberName.apply("Willie J. Perkins, Sr.")
    assert member_struct.first_name == "Willie"
  end

  test "create MemberName struct for Willie J. Perkins, Sr., get last name" do
    member_struct = ProcessMemberName.apply("Willie J. Perkins, Sr.")
    assert member_struct.last_name == "Perkins"
  end

  test "create MemberName struct for Willie J. Perkins, Sr., get suffix" do
    member_struct = ProcessMemberName.apply("Willie J. Perkins, Sr.")
    assert member_struct.suffix == "Sr"
  end

  test "create MemberName struct for Mark Tullos, get last name" do
    member_struct = ProcessMemberName.apply("Mark Tullos")
    assert member_struct.last_name == "Tullos"
  end

end
