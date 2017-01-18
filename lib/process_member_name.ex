defmodule MsLegis.ProcessMemberName do
  def apply(name) do
    name
    |> remove_punctuation
    |> String.split(" ")
  end

  def remove_commas(name) do
    String.replace(name, ",", "")
  end

  def remove_periods(name) do
    String.replace(name, ".", "")
  end

  def remove_punctuation(name) do
    name |> remove_commas |> remove_periods
  end

  def get_suffix(name) do
    suffixes = ["II", "III", "IV", "V", "Jr", "Sr"]
    find_ending = fn(suffix) -> String.ends_with?(name, " " <> suffix) end
    result = Enum.find(suffixes, find_ending)

    if result == nil do
      ""
    else
      result
    end
  end
end
