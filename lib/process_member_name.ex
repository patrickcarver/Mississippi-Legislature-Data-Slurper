defmodule MsLegis.ProcessMemberName do
  alias MsLegis.MemberName

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

  def is_suffix?(value) do
    value in @suffixes
  end

  def get_suffix(value) do
    if is_suffix?(value) do
      value
    else
      ""
    end
  end


  def get_last_name(name, "") do
    List.last(name)
  end

  def get_last_name(name, suffix) do
    Enum.at(name, -2)
  end

  def get_struct(name) do

    first_name = List.first(name)
    middle_name = ""
    nick_name = ""
    last_name = ""

    suffix = get_suffix(List.last(name))
    last_name = get_last_name(name, suffix)

    MemberName.new(%{
      first_name: first_name,
      middle_name: middle_name,
      nick_name: nick_name,
      last_name: last_name,
      suffix: suffix
    })

  end
end
