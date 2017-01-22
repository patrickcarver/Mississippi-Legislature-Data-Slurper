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

  def is_suffix?(value) do
    value in @suffixes
  end

  def get_suffix(value) do
    if is_suffix?(name.last) do
      name.last
    else
      ""
    end
  end

  def get_struct(name) do
    first_name = name.first
    middle_name = ""
    nick_name = ""
    last_name = ""

    suffix = get_suffix(name.last)

    if suffix = "" do
      last_name = name.last
    end



    %MemberName.new({
      first_name: first_name,
      middle_name: middle_name,
      nick_name: nick_name,
      last_name: last_name,
      suffix: suffix
    })

  end
end
