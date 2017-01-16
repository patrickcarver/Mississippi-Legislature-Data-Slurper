defmodule MsLegis.GetXQueryResult do
  import SweetXml

  def get_text(xml, query) do
    xml |> xpath(sigil_x(query, 's'))
  end

  def get_list(xml, query) do
    xml |> xpath(sigil_x(query, 'sl'))
  end
end
