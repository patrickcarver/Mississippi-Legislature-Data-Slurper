defmodule MsLegis.CleanXml do
  def apply(text, metadata) do
    text
    |> remove_whitespace
    |> String.replace(metadata, "")
  end

  def remove_whitespace(text) do
    text
    |> String.replace("\r", "")
    |> String.replace("\n", "")
    |> String.replace("\t", "")
  end

  def remove_bad_quotes(text) do
    text
    |> String.replace(<<147>>, "")
    |> String.replace(<<148>>, "")
  end
end
