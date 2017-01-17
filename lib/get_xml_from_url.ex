defmodule MsLegis.GetXmlFromUrl do
  def apply(url) do
    response = HTTPotion.get(url)
    response.body
  end
end
