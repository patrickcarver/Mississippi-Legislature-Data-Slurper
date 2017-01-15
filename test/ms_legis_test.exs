defmodule MsLegisTest do
  use ExUnit.Case
  doctest MsLegis

  setup_all do
    {:ok, []}
  end

  test "test remove newline", state do
    original = "Hello World\r\n"
    cleaned = MsLegis.CleanXml.remove_whitespace(original)

    assert cleaned == "Hello World"
  end

  test "test remove tab", state do
    original = "Hello \tWorld"
    cleaned = MsLegis.CleanXml.remove_whitespace(original)

    assert cleaned == "Hello World"
  end

  test "test remove newline and tab", state do
    original = "Hello \tWorld\r\n"
    cleaned = MsLegis.CleanXml.remove_whitespace(original)

    assert cleaned == "Hello World"
  end

  test "test remove bad quotes", state do
    original = <<147>> <> "Hello World" <> <<148>>
    cleaned = MsLegis.CleanXml.remove_bad_quotes(original)

    assert cleaned == "Hello World"
  end



end
