defmodule MsLegis do

  def run do
    IO.puts "--- Started ---"
    xml_top = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><?xml-stylesheet type=\"text/xsl\" href=\"dtds_xslts/memberlist.xslt\"?> <!DOCTYPE LEGISLATURE SYSTEM \"dtds_xslts/memberlist.dtd\"> "
    house_url = "http://billstatus.ls.state.ms.us/members/hr_membs.xml"
    response = HTTPotion.get house_url
    xml = response.body
          |> String.replace("\r", "")
          |> String.replace("\n", "")
          |> String.replace("\t", "")
          |> String.replace(xml_top, "")
    IO.puts xml

    IO.puts "--- Finished ---"
  end
end
