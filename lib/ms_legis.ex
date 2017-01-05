defmodule MsLegis do
  import SweetXml

  def run do
    IO.puts "--- Started ---"

    house_url = "http://billstatus.ls.state.ms.us/members/hr_membs.xml"
    response = HTTPotion.get house_url
    links_list = response.body |> clean_xml |> create_list

    IO.puts "--- Finished ---"
  end

  def create_list(xml) do
    chair_link = xml |> xpath(~x"//CHAIR_LINK/text()")
    protemp_link = xml |> xpath(~x"//PROTEMP_LINK/text()")

    officer_links = [chair_link, protemp_link]

    m1_links = xml |> xpath(~x"//MEMBER/M1_LINK/text()"l)
    m2_links = xml |> xpath(~x"//MEMBER/M2_LINK/text()"l)
    m3_links = xml |> xpath(~x"//MEMBER/M3_LINK/text()"l)
    m4_links = xml |> xpath(~x"//MEMBER/M4_LINK/text()"l)
    m5_links = xml |> xpath(~x"//MEMBER/M5_LINK/text()"l)

    officer_links ++ m1_links ++ m2_links ++ m3_links ++ m4_links ++ m5_links
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
