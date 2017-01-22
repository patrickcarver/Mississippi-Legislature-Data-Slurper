defmodule MsLegis.ProcessMemberName do
  @suffixes ["II", "III", "IV", "V", "Jr", "Sr"]

  def apply(name) do
    name
    |> remove_punctuation
    |> String.split(" ", trim: true)
    |> get_struct
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

  def is_suffix(value) do
    value in @suffixes
  end

  def get_struct(name) do
    # is last in suffixes?
    
  end
end
