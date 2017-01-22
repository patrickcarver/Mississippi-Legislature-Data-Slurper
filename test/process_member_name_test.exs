defmodule ProcessMemberNameTest do
  use ExUnit.Case

  alias MsLegis.{
    ProcessMemberName
  }

  setup_all do
    {:ok, [perkins_struct: ProcessMemberName.apply("Willie J. Perkins, Sr.")]}
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

  test "create struct for Willie J. Perkins, Sr., get first name", context do
    assert context[:perkins_struct].first_name == "Willie"
  end

  test "create struct for Willie J. Perkins, Sr., get last name", context do
    assert context[:perkins_struct].last_name == "Perkins"
  end

  test "create MemberName struct for Willie J. Perkins, Sr., get suffix", context do
    assert context[:perkins_struct].suffix == "Sr"
  end

  test "create MemberName struct for Mark Tullos, get last name" do
    member_struct = ProcessMemberName.apply("Mark Tullos")
    assert member_struct.last_name == "Tullos"
  end
end
