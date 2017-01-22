defmodule MsLegis.MemberName do
  defstruct first_name: "",
            middle_name: "",
            last_name: "",
            nick_name: "",
            suffix: ""

  use ExConstructor
end
