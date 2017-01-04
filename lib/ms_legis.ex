defmodule MsLegis do
  import SweetXml

  def run do
    IO.puts "--- Started ---"
    house_url = "http://billstatus.ls.state.ms.us/members/hr_membs.xml"
    response = HTTPotion.get house_url
    xml = response.body |> clean_xml

    chairman_name = xml |> xpath(~x"//CHAIR_NAME/text()")
    IO.puts chairman_name

    IO.puts "--- Finished ---"
  end

  defp clean_xml(text) do
    xml_top = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><?xml-stylesheet type=\"text/xsl\" href=\"dtds_xslts/memberlist.xslt\"?> <!DOCTYPE LEGISLATURE SYSTEM \"dtds_xslts/memberlist.dtd\"> "
    text
      |> String.replace("\r", "")
      |> String.replace("\n", "")
      |> String.replace("\t", "")
      |> String.replace(xml_top, "")
  end
end
