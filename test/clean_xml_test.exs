defmodule CleanXmlTest do
  use ExUnit.Case
  alias MsLegis.{ CleanXml }

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
end
